FROM openjdk:8-jre

ENV SCALA_VERSION 2.11.11
ENV SBT_VERSION 0.13.16

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install --no-install-recommends -y --force-yes sbt && \
  sbt sbtVersion && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Install git
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y --force-yes git ssh fakeroot && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Install docker
RUN \
  VER="17.03.0-ce" && \
  curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz && \
  tar -xz -C /tmp -f /tmp/docker-$VER.tgz && \
  mv /tmp/docker/* /usr/bin

# Define working directory
WORKDIR /root
