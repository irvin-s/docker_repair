FROM alpine:edge
MAINTAINER qgp9 

# EDGE BASE SET
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && apk upgrade && apk update
RUN apk add --update bash && rm -rf /var/cache/apk/*  

# ADDITIONAL SET

# REDIS
RUN apk add --update mongodb && rm -rf /var/cache/apk/*  

RUN mkdir -p /data/db /data/logs 

WORKDIR /data

VOLUME ["/data" ]

EXPOSE 27017

CMD ["mongod","-f","/etc/mongod.conf"]
