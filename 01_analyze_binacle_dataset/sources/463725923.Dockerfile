FROM alpine:latest as tools
RUN apk update && apk add curl tar
RUN curl -f -L \
  https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz \
  | tar -xzv -C /usr/local/bin/

FROM jbenet/go-ipfs:release
RUN mkdir -p /usr/bin
COPY --from=tools /usr/local/bin/dig /usr/bin/dig
COPY start.sh ./

ENTRYPOINT ["/sbin/tini", "--", "./start.sh"]
