FROM docker:17.12-rc-dind

RUN apk add --no-cache curl

WORKDIR /tool

COPY daemon.json /etc/docker/daemon.json
COPY diagnosticClient /tool/diagnosticClient