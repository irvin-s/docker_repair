FROM ubuntu:14.04
MAINTAINER spalladino@manas.com.ar

ENV BIND_ADDRESS 0.0.0.0
ENV BIND_PORT 8090

EXPOSE ${BIND_PORT}

ARG APP_BINARY=build/rancher-autoredeploy
ADD ${APP_BINARY} /app/rancher-autoredeploy
CMD "/app/rancher-autoredeploy"
