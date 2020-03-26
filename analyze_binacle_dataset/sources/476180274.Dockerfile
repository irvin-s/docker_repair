# Grafana
# @version commit: a79c1cb23f0a68edbb
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN yum install git golang wget tar bzip2 -y

# Node
WORKDIR /tmp
RUN wget -nv -O - https://nodejs.org/dist/v0.12.6/node-v0.12.6-linux-x64.tar.gz | tar zx
RUN mv /tmp/node-v0.12.6-linux-x64 /usr/local/node
RUN ln -s /usr/local/node/bin/* /usr/local/bin

ENV GOPATH /root/go

RUN mkdir -p /root/go/src/github.com/grafana

# Fetch project
RUN git clone https://github.com/grafana/grafana.git /root/go/src/github.com/grafana/grafana
WORKDIR /root/go/src/github.com/grafana/grafana
RUN git checkout a79c1cb23f0a68edbb

# Build project
RUN go run build.go setup
RUN /root/go/bin/godep restore
RUN go build .

RUN npm install
RUN npm install -g grunt-cli
RUN grunt

EXPOSE 3000

VOLUME ["/var/lib/grafana"]
VOLUME ["/var/log/grafana"]
VOLUME ["/etc/grafana"]

WORKDIR /root/go/src/github.com/grafana/grafana

ENTRYPOINT ["/root/go/src/github.com/grafana/grafana/grafana", "--config", "/etc/grafana/grafana.ini"]
