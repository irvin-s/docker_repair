FROM ubuntu:18.04
MAINTAINER showwin <showwin_kmc@yahoo.co.jp>

RUN apt-get update
RUN apt-get install -y wget

# Go のインストール
RUN wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
ENV GOROOT /usr/local/go
ENV GOPATH $HOME/.local/go
ENV PATH $PATH:$GOROOT/bin

# MySQL のインストール
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password ishocon'"]
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-service mysql-server/mysql-apt-config string 4'"]
RUN apt-get install -y mysql-server

COPY admin/ admin/

# build benchmark
RUN apt-get install -y git
RUN cd /admin && go get -t -d -v ./... && go build -o benchmark benchmarker/*.go
RUN mv /admin/benchmark ~/

# MySQL 初期設定
RUN cp /admin/config/my.cnf /etc/mysql/my.cnf

COPY docker/start_bench.sh /docker/start_bench.sh

WORKDIR /root
