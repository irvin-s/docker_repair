FROM docker-dev.yelpcorp.com/xenial_pkgbuild

MAINTAINER Tomas Doran <bobtfish@bobtfish.net>

ENV PATH /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/go/bin:/go/bin
ENV GOPATH /go
ENV RUBYOPT="-KU -E utf-8:utf-8"

RUN mkdir -p /go && \
    git clone https://github.com/hashicorp/terraform.git /go/src/github.com/hashicorp/terraform && \
    cd /go/src/github.com/hashicorp/terraform && \
    git checkout v0.12.1
