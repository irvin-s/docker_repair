FROM golang:1.6

COPY . /go/src/github.com/generationtux/brizo
RUN cd /go/src/github.com/generationtux/brizo && \
    go build && \
    rm -rf ./vendor && rm -rf ./ui/node_modules

WORKDIR /go/src/github.com/generationtux/brizo
ENTRYPOINT /go/src/github.com/generationtux/brizo/brizo
