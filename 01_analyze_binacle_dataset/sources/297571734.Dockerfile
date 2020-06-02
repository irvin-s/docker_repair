FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.roslin="1.0.0" \
      version.alpine="3.5.x"

ENV ROSLIN_PIPELINE_VERSION 1.0.0

ADD welcome.txt /

RUN apk add --update bash

ENTRYPOINT ["cat", "/welcome.txt"]
