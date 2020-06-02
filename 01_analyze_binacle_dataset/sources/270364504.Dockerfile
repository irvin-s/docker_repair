FROM centos:7

RUN yum -y update && \
    yum -y install wget git && \
    wget 'https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz' && \
    tar zvxf go1.8.linux-amd64.tar.gz
WORKDIR /usr/local/bin
RUN ln /go/bin/go go
ENV GOROOT /go
ENV GOPATH /root/go
ENV PATH $PATH:$GOPATH/bin
RUN go get -u github.com/rakyll/hey
CMD ["/bin/sh", "-c", "hey -n 10000 -c 100 http://nginx.resorcerer.svc"]
