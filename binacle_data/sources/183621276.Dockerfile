FROM centos:centos7

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y group install 'Development Tools' && \
    yum -y install golang && \
    yum clean all

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN mkdir -p /package/root/ && \
    mkdir -p /package/root/etc/ && \
    mkdir -p /package/root/usr/bin/ && \
    mkdir -p /package/root/etc/mesos-dns/ && \
    mkdir -p /package/root/lib64/

RUN go get github.com/tools/godep
RUN go get github.com/kardianos/govendor

RUN cd /package/root/etc/ && ln -s /proc/mounts mtab

COPY etc/group /package/root/etc/
COPY etc/hostname /package/root/etc/
COPY etc/hosts /package/root/etc/
COPY etc/nsswitch.conf /package/root/etc/
COPY etc/passwd /package/root/etc/
COPY etc/resolv.conf /package/root/etc/

COPY Makefile /

WORKDIR /

CMD ["make", "docker-rootfs"]
