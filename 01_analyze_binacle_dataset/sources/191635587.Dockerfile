FROM gliderlabs/alpine:3.1
VOLUME /mnt/routes
EXPOSE 8000

ENV GOPATH /go
RUN apk-install go
RUN apk-install ca-certificates
COPY tmp/src /go/src
WORKDIR /go/src/github.com/gliderlabs/logspout
CMD go build -ldflags "-X main.Version dev" -o /bin/logspout \
	&& exec /bin/logspout
