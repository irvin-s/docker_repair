FROM alpine

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install speedtest-cli \
  && rm -rf /var/cache/apk/*

ENTRYPOINT ["speedtest-cli"]
