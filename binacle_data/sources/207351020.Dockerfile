FROM armhfbuild/alpine:3.4

RUN apk update && \
  apk add \
    ca-certificates && \
  rm -rf /var/cache/apk/*

ADD drone-sftp-cache /bin/
ENTRYPOINT ["/bin/drone-sftp-cache"]
