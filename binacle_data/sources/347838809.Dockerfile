FROM golang:1.8

MAINTAINER YanMing, yanming02@baidu.com

COPY . /go/src/github.com/ksarch-saas/cc

RUN cd /go/src/github.com/ksarch-saas/cc && ./godep go install

WORKDIR /go/src/github.com/ksarch-saas/cc

ENTRYPOINT ["cc"]
