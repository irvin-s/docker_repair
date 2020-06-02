FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE\
      org.label-schema.vcs-url="https://github.com/comodal/alpine-gcc-make.git"\
      org.label-schema.vcs-ref=$VCS_REF\
      org.label-schema.name="GCC & Make Alpine:edge Image"\
      org.label-schema.usage="https://github.com/comodal/alpine-gcc-make#docker-run"\
      org.label-schema.schema-version="1.0.0-rc.1"

RUN set -x\
 && apk add --no-cache\
  gcc\
  make\
  musl-dev
