# build
FROM golang:1.9.4-alpine3.7 as builder

ENV BUILD_HOME /go/src/github.com/EducationEKT/EKT
WORKDIR /root
COPY . $BUILD_HOME
RUN echo "https://mirrors.aliyun.com/alpine/v3.7/main" > /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.7/community" >> /etc/apk/repositories \
    && apk update && apk add --no-cache gcc libc-dev
RUN cd $BUILD_HOME && go build -o ekt8 cmd/enode/main.go

# pack
FROM alpine:3.7

ENV BUILD_HOME /go/src/github.com/EducationEKT/EKT
WORKDIR /root
COPY --from=builder $BUILD_HOME/ekt8 .
COPY docker/entrypoint.sh .
COPY genesis.json .
ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]
