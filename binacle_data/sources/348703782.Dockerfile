FROM alpine:3.2

MAINTAINER Oleksii Fedorov <waterlink000@gmail.com>

ADD . /src
WORKDIR /src

ENV PROTOBUF_TAG v3.0.0-alpha-3.1

RUN ./build.sh

ENTRYPOINT ["protoc"]
