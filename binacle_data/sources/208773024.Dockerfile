FROM openjdk:8u121-jre-alpine

ARG LICENSE_KEY=""

RUN apk add --update bash && rm -fr /var/cache/apk/*
WORKDIR /root/
ADD cobaltstrike-trial.tgz .
WORKDIR /root/cobaltstrike
RUN echo $LICENSE_KEY | ./update
CMD ./teamserver $HOST $PASSWORD
