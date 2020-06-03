FROM openjdk:8-alpine

RUN apk add --no-cache nodejs git openssh tar gzip bash make wget ca-certificates netcat-openbsd
ADD wait-for-command.sh /usr/bin/
