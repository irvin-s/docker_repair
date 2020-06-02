FROM gliderlabs/alpine:3.2

RUN apk-install go git build-base vim
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN go get github.com/mailgun/godebug

ADD . /go/src/github.com/x-cray/marathon-registrator
RUN cd /go/src/github.com/x-cray/marathon-registrator \
	&& go get -d -v \
	&& go build -ldflags "-X main.version dev" -o /bin/registrator

CMD ["/bin/registrator"]
