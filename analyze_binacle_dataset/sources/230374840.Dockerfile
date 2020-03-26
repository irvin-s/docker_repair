FROM golang:1.7.6

COPY ./ /go/src/github.com/contiv/auth_proxy

WORKDIR /go/src/github.com/contiv/auth_proxy

ENTRYPOINT ["/bin/bash", "./scripts/build_in_container.sh"]
