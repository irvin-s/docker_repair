FROM ubuntu:14.04
ENV GOPATH /go
RUN apt-get -y update --no-install-recommends
RUN apt-get -y install --no-install-recommends golang-go bzr git ca-certificates
RUN go get github.com/peterbourgon/diskv
RUN go get github.com/getlantern/go-mitm/mitm
RUN go get github.com/nu7hatch/gouuid
ADD run.sh /run.sh
ADD . /go/src/github.com/lox/package-proxy
ENV GOBIN /go/bin
ENV PATH $GOBIN:$PATH
WORKDIR /go/src/github.com/lox
CMD ["./package-proxy","-dir","/tmp/cache","-tls"]