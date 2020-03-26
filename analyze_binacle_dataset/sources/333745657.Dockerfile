FROM ubuntu:16.04

ENV OS_FAMILY ubuntu
ENV OS_VERSION 16.04

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    wget \
    curl \
    lsof \
    git \
    build-essential \
    telnet \
    tar \
    htop

COPY ./soft/upx-amd64_linux.tar.xz /upx-amd64_linux.tar.xz
RUN cd / && (rm -rf ./upxdata || true) && mkdir ./upxdata && tar xpvfJ upx-amd64_linux.tar.xz --strip 1 -C ./upxdata/ && cp ./upxdata/upx /usr/local/bin/upx && chmod a+x /usr/local/bin/upx && rm /upx-amd64_linux.tar.xz && rm -rf ./upxdata

COPY ./soft/go.linux-amd64.tar.gz /go.linux-amd64.tar.gz
RUN cd / && tar -C /usr/local -xzf go.linux-amd64.tar.gz && rm /go.linux-amd64.tar.gz
RUN mkdir -p /root/go/src
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
RUN echo 'export GOROOT=$HOME/go' >> ~/.profile
RUN echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.profile
ENV PATH="${PATH}:/usr/local/go/bin"

RUN go get github.com/golang/dep/cmd/dep
RUN go get github.com/gobuffalo/packr/...
RUN go get github.com/rubenv/sql-migrate/...

RUN ln -sf /root/go/bin/dep /usr/local/bin/dep && \
    ln -sf /root/go/bin/packr /usr/local/bin/packr && \
    ln -sf /root/go/bin/sql-migrate /usr/local/bin/sql-migrate

ADD ./docker-entry.sh /docker-entry.sh

CMD ["/docker-entry.sh"]
