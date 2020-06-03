FROM ubuntu:18.04
LABEL maintainer="Erik Rogers <erik.rogers@live.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV BURSTCOIN_VERSION 2.2.1
ENV BURSTCOIN_PACKAGE burstcoin-${BURSTCOIN_VERSION}
ENV BURSTCOIN_ARCHIVE ${BURSTCOIN_PACKAGE}.zip

ENV BURSTCOIN_RELEASE https://github.com/PoC-Consortium/burstcoin/releases/download/${BURSTCOIN_VERSION}/${BURSTCOIN_ARCHIVE}

ENV BURSTCOIN_DATA_DIR /data/burstcoin

# Install Burstcoin dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre \
    wget \
    ca-certificates \
    ca-certificates-java \
    socat \
    unzip \
  && apt-get upgrade -y \
  && apt-get dist-upgrade -y \
  && apt-get autoremove \
  && rm -rf /var/cache/apk/*

# Download Burstcoin and unzip to data directory
WORKDIR /tmp
RUN wget ${BURSTCOIN_RELEASE} \
  && mkdir -p ${BURSTCOIN_DATA_DIR} \
  && unzip ${BURSTCOIN_ARCHIVE} -d ${BURSTCOIN_DATA_DIR} \
  && rm ${BURSTCOIN_ARCHIVE}

# Copy shell script and make executable
COPY *.sh $BURSTCOIN_DATA_DIR
WORKDIR ${BURSTCOIN_DATA_DIR}
RUN chmod +x *.sh

# Default DB env vars
ENV DB_HOST localhost	
ENV DB_PORT 3306
ENV DB_NAME burstwallet	
ENV DB_USERNAME burstwallet
ENV DB_PASSWORD secret

# Expose P2P and web UI ports
EXPOSE 8123 8125

# Start Burstcoin daemon
VOLUME ${BURSTCOIN_DATA_DIR}
ENTRYPOINT ["./entrypoint.sh"]