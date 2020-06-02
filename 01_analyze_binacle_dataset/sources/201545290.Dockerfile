FROM gliderlabs/alpine:3.2
RUN apk-install ca-certificates && \
  rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/rancher-ecr-credentials"]
ADD rancher-ecr-credentials /bin/
