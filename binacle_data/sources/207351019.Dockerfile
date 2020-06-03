FROM alpine:3.4

LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>"

RUN apk update && \
  apk add \
    ca-certificates && \
  rm -rf /var/cache/apk/*

ADD drone-sftp-cache /bin/
ENTRYPOINT ["/bin/drone-sftp-cache"]
