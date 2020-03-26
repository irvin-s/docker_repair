FROM golang:1.7.6

# go-check must be installed to run systemtests
RUN go get gopkg.in/check.v1

COPY ./ /go/src/github.com/contiv/auth_proxy

WORKDIR /go/src/github.com/contiv/auth_proxy

ENTRYPOINT ["/bin/bash"]
