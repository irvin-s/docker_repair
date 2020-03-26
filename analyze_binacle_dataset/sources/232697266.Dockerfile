FROM alpine:3.4

RUN apk add --no-cache git nodejs &&\
    git clone https://github.com/etsy/statsd.git &&\
    apk del git

WORKDIR /statsd

EXPOSE 8125

ADD run.sh /

ENTRYPOINT ["/run.sh"]

CMD ["config.js"]
