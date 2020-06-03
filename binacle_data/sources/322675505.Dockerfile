FROM golang:latest

ADD client /usr/bin/

ENTRYPOINT /usr/bin/client
