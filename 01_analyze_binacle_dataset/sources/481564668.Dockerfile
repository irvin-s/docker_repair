FROM golang:1.6.2-alpine

COPY . /go

ENV CONSUL_TEMPLATE_VERSION=0.10.0

# Updata wget to get support for SSL
RUN apk --update add wget

WORKDIR    /go/src
RUN        go install f5-controller

# Download consul-template
RUN ( wget --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -O /tmp/consul_template.zip && unzip /tmp/consul_template.zip && mv consul-template /usr/bin && rm -rf /tmp/* )

WORKDIR /go/src/f5-controller

RUN mkdir config