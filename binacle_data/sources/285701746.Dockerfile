FROM golang:1.9.2-alpine AS builder
WORKDIR $GOPATH/src/github.com/travelaudience/kubernetes-vault-example
COPY . .
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /client -v ./client.go

FROM alpine:3.6
COPY --from=builder /client /usr/local/bin/
CMD ["client"]
