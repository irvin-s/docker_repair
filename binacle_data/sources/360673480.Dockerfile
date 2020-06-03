FROM gliderlabs/alpine:3.2

ADD . /go/src/github.com/x-cray/marathon-registrator
RUN apk-install -t build-deps go git \
	&& cd /go/src/github.com/x-cray/marathon-registrator \
	&& export GOPATH=/go \
	&& go get -d -v \
	&& go build -ldflags "-X main.version $(cat VERSION)" -o /bin/registrator \
	&& rm -rf /go \
	&& apk del --purge build-deps

ENTRYPOINT ["/bin/registrator"]
