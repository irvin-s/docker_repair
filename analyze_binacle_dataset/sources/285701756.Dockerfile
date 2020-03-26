FROM golang:1.9.2-alpine AS builder
WORKDIR $GOPATH/src/github.com/travelaudience/kubernetes-vault-example
COPY ./server.go ./server.go
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /server -v ./server.go

FROM alpine:3.6
COPY --from=builder /server /usr/local/bin/
EXPOSE 443
CMD ["server"]
