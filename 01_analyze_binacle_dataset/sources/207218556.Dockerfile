FROM gliderlabs/alpine:latest

MAINTAINER Gowtham Sadasivam <http://gowthamsadasivam.me>

LABEL Package="BetterCAP" \
      Version="Latest-Stable" \
      Description="BetterCAP the state of the art, modular, portable and easily extensible MITM framework in a Container" \
      Destro="Alpine Linux" \
      GitHub="https://github.com/gowthamsadasivam/docker-bettercap" \
      DockerHub="https://hub.docker.com/r/gowthamsadasivam/docker-bettercap/" \
      Maintainer="Gowtham Sadasivam"

RUN apk add --update ca-certificates && \
    apk add --no-cache --update \
    bash \
    build-base \
    musl-dev \
    ruby \
    ruby-dev \
    ruby-irb \
    ruby-rdoc \
    libcap-dev \
    libpcap-dev \
    iptables-dev && \
    rm -rf /var/cache/apk/* /tmp/*


RUN gem install bettercap

EXPOSE 80 443 5300 8080 8081 8082 8083

ENTRYPOINT ["bettercap"]
CMD ["-h"]
