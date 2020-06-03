FROM alpine:latest

MAINTAINER "Arukas Team <support@arukas.io>"

ENV AUTHORIZED_KEYS ***YOUR_AUTHORIZED_KEYS***

RUN apk add --update openssh pwgen && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh .
COPY keygen.sh .
COPY pwgen.sh .

EXPOSE 22/tcp

CMD ["/entrypoint.sh"]
