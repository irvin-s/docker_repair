FROM centos:centos7

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y group install 'Development Tools' && \
    yum -y install golang rubygems ruby-devel && \
    yum clean all && \
    gem install fpm

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN mkdir -p /package/root/ && \
    mkdir -p /package/root/usr/bin/ && \
    mkdir -p /package/root/etc/mesos-dns/

RUN go get github.com/tools/godep

COPY mesos-dns.service /package/root/usr/lib/systemd/system/
COPY Makefile /

WORKDIR /

CMD ["make", "el7"]
