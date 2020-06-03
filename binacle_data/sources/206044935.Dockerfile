FROM centos:latest

MAINTAINER Trevor McKay tmckay@redhat.com

ENV OSHINKO_CLI 1.0

USER root
RUN yum install -y golang make git && \
    yum clean all

ENV GOPATH /go
ADD . /go/src/github.com/radanalyticsio/oshinko-cli

RUN cd /go/src/github.com/radanalyticsio/oshinko-cli && \
    make build && \
    cp _output/oshinko-cli /opt && \
    chown -R 1001:1001 /opt/oshinko-cli && \
    chmod +x /opt/oshinko-cli

USER 1001
