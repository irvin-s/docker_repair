FROM golang:1.10 as builder

WORKDIR /go/src/github.com/lawrencegripper/ion/

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o ./downloadfile ./modules/downloadfile/main.go

FROM alpine:3.7
RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /go/src/github.com/lawrencegripper/ion/downloadfile .
ENTRYPOINT ["./downloadfile"]
