FROM golang:1.12-alpine AS go-build

WORKDIR /go/src/github.com/hunterhug/rabbit

COPY . /go/src/github.com/hunterhug/rabbit/
#COPY vendor /go/src/github.com/hunterhug/fafacms/vendor
#COPY main.go /go/src/github.com/hunterhug/fafacms/main.go

RUN go build -ldflags "-s -w" -v -o rabbit main.go

FROM alpine:3.9 AS prod

WORKDIR /go/src/github.com/hunterhug/rabbit
COPY --from=go-build /go/src/github.com/hunterhug/rabbit/rabbit /go/src/github.com/hunterhug/rabbit/rabbit
COPY . /go/src/github.com/hunterhug/rabbit/
RUN chmod 777 /go/src/github.com/hunterhug/rabbit/rabbit
CMD /go/src/github.com/hunterhug/rabbit/rabbit $RUN_OPTS
