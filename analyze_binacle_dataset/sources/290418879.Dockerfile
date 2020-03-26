
### BUILDER ###

FROM golang:alpine AS builder

WORKDIR /go/src/github.com/mycujoo/kube-deploy
RUN apk update && apk add git
COPY . .
RUN  go get -d -v .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -v -installsuffix cgo .

### FINAL IMAGE ###

FROM alpine
RUN apk update && \
    apk add \
        git \
        curl \
        bash \
        docker \
        sudo \
        htop \
        vim \
        unzip

RUN addgroup -S kube-deploy && adduser -S -g kube-deploy kube-deploy

ENV CONSUL_TEMPLATE_VERSION 0.19.4
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_0.19.4_linux_amd64.zip /

RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates

ADD https://releases.hashicorp.com/vault/0.9.0/vault_0.9.0_linux_amd64.zip?_ga=2.88696664.258531381.1513588748-1229534726.1508153142 /

RUN unzip vault_0.9.0_linux_amd64.zip && \
    mv vault /usr/local/bin/vault && \
    rm -rf /vault_0.9.0_linux_amd64.zip

ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN mkdir -p /kube-deploy/locks

USER kube-deploy
WORKDIR /src

COPY --from=0 /go/src/github.com/mycujoo/kube-deploy/kube-deploy /usr/local/bin/kube-deploy
ENTRYPOINT ["kube-deploy"]

