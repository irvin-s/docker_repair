FROM alpine
MAINTAINER qgp9 

# BASE SET
RUN apk update && apk upgrade && apk update
RUN apk add --update bash && rm -rf /var/cache/apk/*  

# ADDITIONAL SET

# REDIS
RUN apk add --update redis && rm -rf /var/cache/apk/*  

RUN mkdir /data

WORKDIR /data

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
