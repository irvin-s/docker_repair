# --- Stage1: Get Maven ---
FROM buildpack-deps:jessie as ntr-base
ENV MAVEN_VERSION 3.5.2
ENV MAVEN_HOME /usr/share/maven

# install maven
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL "http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar xzf - -C /usr/share \
  && mv "/usr/share/apache-maven-${MAVEN_VERSION}" /usr/share/maven
# -> used artifacts: /usr/share/maven

# --- Stage2: Install Clouseau
FROM erlang:18-slim as ntr-clouseau-build
ENV MAVEN_HOME /usr/share/maven
ENV CLOUSEAU_PATH /opt/clouseau
ENV INDEX_DIR /index

# setup maven
COPY --from=ntr-base /usr/share/maven $MAVEN_HOME
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && ls -l /usr/bin/mvn

# finish clouseau
RUN groupadd -r clouseau && useradd -d "$CLOUSEAU_PATH" -g clouseau clouseau
RUN apt-get -qq update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
  build-essential \
  apt-transport-https \
  libnspr4 libnspr4-0d \
  openssl \
  curl \
  ca-certificates \
  git \
  pkg-config \
  openjdk-7-jdk \
  && rm -rf /var/lib/apt/lists/*

# Install project dependencies and keep sources
# make source folder
RUN mkdir /clouseau_deps "$CLOUSEAU_PATH"

WORKDIR /clouseau_deps

# install maven dependency packages (keep in image)
RUN curl https://raw.githubusercontent.com/neutrinity/clouseau/ntr_master/pom.xml -o pom.xml \
&& curl https://raw.githubusercontent.com/neutrinity/clouseau/ntr_master/src/main/assembly/distribution.xml --create-dirs -o src/main/assembly/distribution.xml \
&& mvn -T 1C install -Dmaven.test.skip=true

WORKDIR $CLOUSEAU_PATH
# now we can add all source code and start compiling
RUN git clone -b ntr_master https://github.com/neutrinity/clouseau . \
  && cp -RT /clouseau_deps/ "${CLOUSEAU_PATH}/" && rm -r /clouseau_deps

# TODO tests need to get unskipped
RUN mvn verify -Dmaven.test.skip=true

# --- Stage3: Finalize Clouseau
FROM erlang:18-slim as ntr-clouseau
ENV CLOUSEAU_PATH /opt/clouseau
ENV INDEX_DIR /index

RUN apt-get -qq update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
  libnspr4 libnspr4-0d \
  curl \
  unzip \
  openjdk-7-jre-headless \
  && rm -rf /var/lib/apt/lists/*

# this is a hack to clean everything up
RUN mkdir -p "${CLOUSEAU_PATH}/lib" \
  && groupadd -r clouseau && useradd -d "$CLOUSEAU_PATH" -g clouseau clouseau

WORKDIR $CLOUSEAU_PATH

COPY --from=ntr-clouseau-build "${CLOUSEAU_PATH}/target/clouseau-2.10.0-SNAPSHOT.zip" .
RUN unzip -j "${CLOUSEAU_PATH}/clouseau-2.10.0-SNAPSHOT.zip" -d "${CLOUSEAU_PATH}/lib" \
  && rm "${CLOUSEAU_PATH}/clouseau-2.10.0-SNAPSHOT.zip"

COPY ./docker-entrypoint.sh $CLOUSEAU_PATH

# Setup directories and permissions
RUN mkdir -p "${CLOUSEAU_PATH}/etc" \
  && touch "${CLOUSEAU_PATH}/etc/clouseau.ini" \
  && chmod +x docker-entrypoint.sh \
  && chown -R clouseau:clouseau "$CLOUSEAU_PATH"

COPY ./clouseau/log4j.properties "${CLOUSEAU_PATH}/etc"

RUN mkdir -p "$INDEX_DIR" && chown -R clouseau:clouseau "$INDEX_DIR"
VOLUME ["$INDEX_DIR"]

USER clouseau
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["clouseau"]
