FROM alpine:latest

RUN apk --no-cache --update add postgresql-client \
    && rm -f /var/cache/apk/*

ENTRYPOINT ["psql"]
