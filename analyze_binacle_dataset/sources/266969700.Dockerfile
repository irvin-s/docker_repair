FROM ubuntu:18.04
LABEL maintainer="Erik Rogers <erik.rogers@live.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV CREEPMINER_VERSION 1.8.2
ENV CREEPMINER_PACKAGE creepMiner-${CREEPMINER_VERSION}.0
ENV CREEPMINER_ARCHIVE ${CREEPMINER_PACKAGE}-Linux.tar.gz

ENV CREEPMINER_RELEASE https://github.com/Creepsky/creepMiner/releases/download/${CREEPMINER_VERSION}/${CREEPMINER_ARCHIVE}

ENV CREEPMINER_DIR /opt/creepMiner-${CREEPMINER_VERSION}

# Install CreepMiner dependencies to build Poco libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    socat \
    openssl \
    libssl-dev \
    ca-certificates \
  && apt-get upgrade -y \
  && apt-get dist-upgrade -y \
  && apt-get autoremove \
  && rm -rf /var/cache/apk/*

# Download CreepMiner and extract
WORKDIR /tmp
RUN wget ${CREEPMINER_RELEASE} \
  && mkdir -p ${CREEPMINER_DIR} \
  && tar xvf ${CREEPMINER_ARCHIVE} -C ${CREEPMINER_DIR} --strip-components=3 \
  && rm ${CREEPMINER_ARCHIVE}

# Add Poco lib to LD_LIBRARY_PATH vars
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:${CREEPMINER_DIR}/lib

# Copy shell script and make executable
COPY *.sh $CREEPMINER_DIR
WORKDIR ${CREEPMINER_DIR}
RUN chmod +x *.sh

# Mount configuration directory, copy defaults
ENV CREEPMINER_DATA_DIR /data/creepMiner
RUN mkdir -p ${CREEPMINER_DATA_DIR}
COPY mining.conf ${CREEPMINER_DATA_DIR}
VOLUME ${CREEPMINER_DATA_DIR}

# Expose API port and run CreepMiner
EXPOSE 8124
ENTRYPOINT ["./entrypoint.sh"]