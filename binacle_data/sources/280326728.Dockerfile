FROM alpine:3.8
MAINTAINER Rohith Jayawardene <gambol99@gmail.com>

RUN apk add ca-certificates --no-cache

ADD bin/policy-admission /policy-admission

USER 1000

ENTRYPOINT [ "/policy-admission" ]
