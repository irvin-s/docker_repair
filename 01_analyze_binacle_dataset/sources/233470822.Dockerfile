FROM golang:1.12.5

RUN wget https://github.com/cloudfoundry/bosh-cli/releases/download/v5.5.1/bosh-cli-5.5.1-linux-amd64
RUN chmod +x bosh-cli-5.5.1-linux-amd64
RUN mv bosh-cli-5.5.1-linux-amd64 /usr/bin/bosh
RUN go get github.com/onsi/ginkgo/ginkgo
RUN go get github.com/onsi/gomega

ENV PATH=$PATH:$GOPATH/bin