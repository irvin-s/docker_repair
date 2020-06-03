FROM golang:1.7.6

RUN go get github.com/gordonklaus/ineffassign
RUN go get github.com/golang/lint/golint
RUN go get github.com/fzipp/gocyclo
RUN go get github.com/client9/misspell/...
RUN go get github.com/remyoudompheng/go-misc/deadcode/...

COPY ./ /go/src/github.com/contiv/auth_proxy

WORKDIR /go/src/github.com/contiv/auth_proxy

ENTRYPOINT ["/bin/bash", "./scripts/checks_in_container.sh"]
