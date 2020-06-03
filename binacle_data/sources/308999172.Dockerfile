FROM golang:1.10 as builder

WORKDIR /go/src/github.com/lawrencegripper/ion/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o ./transcode ./modules/transcode/main.go

# This is a pre-built ffmpeg image with nvidia cuda support
FROM nightseas/ffmpeg 

WORKDIR /root/
COPY --from=builder /go/src/github.com/lawrencegripper/ion/transcode .
ENTRYPOINT ["./transcode"]



