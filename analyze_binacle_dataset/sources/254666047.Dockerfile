FROM alpine
MAINTAINER Prady <pradylibrary@gmail.com>

RUN apk --update add curl bash && \
    rm -rf /var/cache/apk/*

ADD /load-config.sh /
VOLUME /config

ENV CONSUL_URL=localhost
ENV CONSUL_PORT=8500
ENV CONFIG_DIR=/config

RUN chmod +x /load-config.sh

CMD /load-config.sh
