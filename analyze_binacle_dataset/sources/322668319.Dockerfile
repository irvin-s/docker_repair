# node build
FROM node:10-alpine AS node-build-env

ADD ./web/package.json /usr/src/app/
ADD ./web/yarn.lock /usr/src/app/

WORKDIR /usr/src/app

RUN yarn install

ADD ./web /usr/src/app/

RUN yarn build

# golang build
FROM golang:alpine AS go-build-env

RUN apk update && apk add git

RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/UnnoTed/fileb0x

ADD . /go/src/github.com/esnunes/multiproxy
COPY --from=node-build-env /usr/src/app/dist/* /go/src/github.com/esnunes/multiproxy/web/dist/

RUN cd /go/src/github.com/esnunes/multiproxy/ && \
    dep ensure -v && \
    fileb0x assets.yaml && \
    go install ./...

# final stage
FROM alpine
WORKDIR /app
COPY --from=go-build-env /go/bin/multiproxy /app/
ENTRYPOINT ["./multiproxy"]
CMD ["./config.json"]
