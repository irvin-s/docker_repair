FROM anapsix/alpine-java:8_server-jre_unlimited
#FROM alpine:3.7
LABEL maintainer Mattias Giese <mattiasgiese@posteo.net>
ARG YED_VERSION=3.18.0.2
ENV YED_VERSION ${YED_VERSION}
ENV HOME /home/user
ENV LANG C.UTF-8
ENTRYPOINT ["/entrypoint"]

COPY entrypoint /

RUN apk add --no-cache ca-certificates openssl libxext libxrender libxtst libxi \
    && update-ca-certificates \
    && wget -q -O /yed.zip https://www.yworks.com/resources/yed/demo/yEd-$YED_VERSION.zip \
    && unzip /yed.zip -d /usr/local/ \
    && rm /yed.zip \
    && adduser -D user \
    && mkdir /work && chown user /work \
    && chmod +x /entrypoint

USER user
