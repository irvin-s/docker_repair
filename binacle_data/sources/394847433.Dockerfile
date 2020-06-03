FROM ubuntu
MAINTAINER dyzdyz010 "dyzdyz010@gmail.com"

ENV GOPATH /go
ENV PATH $PATH:/go/bin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
        apt-get install -y --force-yes build-essential git golang ruby-dev nodejs npm && apt-get clean && \
        gem install -y compass && ln -s /usr/bin/nodejs /usr/bin/node && npm install -g bower

RUN go get github.com/astaxie/beego github.com/beego/bee github.com/dyzdyz010/Blog && \
        cd /go/src/github.com/dyzdyz010/Blog/static && bower install --allow-root && \
        cd .. && compass compile

WORKDIR /go/src/github.com/dyzdyz010/Blog
VOLUME /go/src/github.com/dyzdyz010/Blog/conf

ENTRYPOINT bee run