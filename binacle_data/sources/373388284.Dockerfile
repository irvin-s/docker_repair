FROM java:8-jdk-alpine

RUN mkdir -p /opt \
    && apk add --no-cache wget \
    && wget -qO- "https://github.com/skavanagh/KeyBox/releases/download/v2.86.00/keybox-jetty-v2.86_00.tar.gz" \
    | tar -xzC /opt

EXPOSE 8443/tcp
VOLUME ["/a/keydb"]

ADD start.sh /a/start.sh
RUN chmod +x /a/start.sh

ENTRYPOINT  ["/a/start.sh"]