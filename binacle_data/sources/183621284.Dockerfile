FROM centos:centos6

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y groupinstall 'Development Tools' && \
    yum -y install golang rubygems ruby-devel && \
    yum clean all && \
    gem install fpm

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN mkdir -p /package/root/ && \
    mkdir -p /package/root/usr/bin/ && \
    mkdir -p /package/root/etc/mesos-dns/ && \
    mkdir -p /package/root/etc/init/

RUN go get github.com/tools/godep

COPY mesos-dns.conf /package/root/etc/init/
COPY Makefile /

WORKDIR /

CMD ["make", "el6"]
