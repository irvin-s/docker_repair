FROM centos:7

RUN yum install -y epel-release
RUN yum install -y wget make git gzip rpm-build nc
RUN yum groupinstall -y "Development tools"

RUN wget https://dl.google.com/go/go1.9.5.linux-amd64.tar.gz -O /tmp/go.linux-amd64.tar.gz && \
    tar xvf /tmp/go.linux-amd64.tar.gz -C /usr/local && \
    rm -f /tmp/go.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
