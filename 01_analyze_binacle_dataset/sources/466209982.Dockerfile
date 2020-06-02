FROM amazonlinux:latest

RUN yum update -y --security && \
    yum install -y \
                wget \
                git \
                tar \
                make \
                gcc

RUN wget -nv https://golang.org/dl/go1.11.4.linux-amd64.tar.gz -O /tmp/go1.11.4.linux-amd64.tar.gz && \
    tar xzf /tmp/go1.11.4.linux-amd64.tar.gz -C /usr/local/ && \
    rm /tmp/go1.11.4.linux-amd64.tar.gz

ENV GOLANG_VERSION=1.11.4
ENV GOROOT /usr/local/go
ENV GOPATH /gopath
ENV PATH   ${GOPATH}/bin:${GOROOT}/bin:${CODIS}/bin:/usr/local/bin:${PATH}
ENV GO111MODULE=on

COPY . /usr/local/src/contentos-go

RUN cd /usr/local/src/contentos-go && \
    go mod download && \
    make -B build

# rpc service:
EXPOSE 8888
# p2p service:
EXPOSE 20338

CMD ["/usr/local/src/contentos-go/run.sh"]