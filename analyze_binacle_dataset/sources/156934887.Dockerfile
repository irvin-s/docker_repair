FROM alpine

RUN apk update && apk add curl bash \
  && curl -SL https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz \
    | zcat > /usr/local/bin/go-cron \
  && chmod u+x /usr/local/bin/go-cron \
  && rm -rf /var/cache/apk/*

COPY go-cron.sh /usr/local/bin/

EXPOSE 18080
CMD ["go-cron.sh"]
