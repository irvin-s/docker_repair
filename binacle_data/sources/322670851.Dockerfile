FROM golang:latest

ADD write-log-pod /usr/bin/

ENTRYPOINT /usr/bin/write-log-pod

