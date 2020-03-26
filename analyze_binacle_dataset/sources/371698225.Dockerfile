FROM golang:1.4.2

MAINTAINER carl 

ENV PATH $PATH:$GOPATH/bin

ADD github.com /go/src/github.com

ADD build.sh /build.sh

RUN chmod +x /build.sh

RUN /build.sh 

ADD hello /go/src/hello

ADD run.sh /

RUN chmod +x /run.sh

CMD ["/run.sh"]
