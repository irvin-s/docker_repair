FROM nginx:alpine

RUN set -x \
  && apk add --update --no-cache ca-certificates curl openssl
