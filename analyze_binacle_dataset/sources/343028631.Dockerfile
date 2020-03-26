FROM golang:alpine as builder
COPY . /go/src/github.com/3tnet/laravel-broadcasting-server-go
WORKDIR /go/src/github.com/3tnet/laravel-broadcasting-server-go
RUN go build -v -o laravel-broadcasting-server-go /go/src/github.com/3tnet/laravel-broadcasting-server-go/cmd/main.go

FROM alpine:latest
RUN apk add -U tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /go/src/github.com/3tnet/laravel-broadcasting-server-go/laravel-broadcasting-server-go /usr/local/bin/laravel-broadcasting-server-go
RUN chmod +x /usr/local/bin/laravel-broadcasting-server-go
EXPOSE 9999
CMD [ "laravel-broadcasting-server-go" ]