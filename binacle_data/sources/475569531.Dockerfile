FROM codeship/aws-deployment:latest
MAINTAINER marko@codeship.com

# Install natsort for use with the CLI release notes script
RUN apk --update add \
    py-pip && \
  pip install natsort && \
  apk --purge del py-pip && \
  rm -rf var/cache/apk/*

WORKDIR /deploy
COPY bin/jet.sh bin/s3.sh ./bin/
COPY _lifecycle.json _website.json ./
