FROM golang:1.9

RUN apt-get update && apt-get install unzip

ARG CONSUL_VERSION=0.9.3
RUN mkdir -p /etc/consul && \
    curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip > /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    unzip -d /usr/bin/ -Xo /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    rm -rf /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip
