FROM travix/gocd-agent:19.4.0-alpine

MAINTAINER estafette.io

ENV ESTAFETTE_CI_SERVER="gocd" \
    DOCKER_API_VERSION="1.38"

# copy builder
COPY estafette-ci-builder /usr/bin/
