FROM bitnami/base-alpine:3.2
MAINTAINER Bitnami <containers@bitnami.com>

RUN apk add --update build-base && \
    rm /var/cache/apk/*
