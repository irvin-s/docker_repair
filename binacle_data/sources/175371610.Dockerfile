# Minimal eod image based on alpine linux.
# Image: jstubbs/eod

from alpine:3.2

RUN apk add --update musl python && rm /var/cache/apk/*
RUN apk add --update bash && rm -f /var/cache/apk/*
RUN apk add --update git && rm -f /var/cache/apk/*
RUN apk add --update py-pip && rm -f /var/cache/apk/*

# install docker package even though it is old to get all dependencies
RUN apk add --update docker && rm -f /var/cache/apk/*

# install the latest docker binary
RUN curl -Lo docker https://get.docker.com/builds/Linux/x86_64/docker-latest
RUN chmod +x /docker
RUN mv /docker /usr/bin

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# supply a default config
ADD endofday.conf /endofday.conf

ADD core /core
ADD tests /tests

ENV STAGING /staging
ENV STAGING_DIR /staging
# WORKDIR /staging

ENTRYPOINT ["/core/endofday.sh"]
