FROM golang:1.10-alpine as builder

LABEL maintainers="anthdm"

ADD ./bin/consenter /usr/bin

ENTRYPOINT ["consenter"]