FROM golang:1.8-alpine

RUN mkdir -p $GOPATH/src/lua_driver
WORKDIR $GOPATH/src/lua_driver
ADD . $GOPATH/src/lua_driver
RUN apk add --no-cache make git curl ca-certificates
RUN go get -v .

RUN go build -o driver .
CMD ./driver
