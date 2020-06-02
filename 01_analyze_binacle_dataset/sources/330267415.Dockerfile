# Builder container
FROM golang:alpine as builder
RUN apk add --update make git gcc g++
RUN go get -u github.com/golang/dep/cmd/dep
COPY . $GOPATH/src/github.com/netm4ul/netm4ul/
WORKDIR $GOPATH/src/github.com/netm4ul/netm4ul/
RUN make
# copy the exe in a simple location (to be used by the next Docker img)
RUN mkdir /build/ && mv $GOPATH/src/github.com/netm4ul/netm4ul/netm4ul /build/netm4ul


# minimal execution node (master/lightweight nodes)
FROM alpine
RUN adduser -S -D -H -h /app netm4ul
USER netm4ul
COPY --from=builder /build/netm4ul /app/netm4ul
WORKDIR /app
ENTRYPOINT ["./netm4ul"]
CMD ["version"]