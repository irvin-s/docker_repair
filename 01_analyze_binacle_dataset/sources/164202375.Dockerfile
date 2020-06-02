FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install golang git mercurial build-essential curl
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN go get github.com/codegangsta/gin

WORKDIR /go/src/github.com/YoApp/counter
ADD . /go/src/github.com/YoApp/counter
ENV GOPATH $GOPATH/src/github.com/YoApp/counter/Godeps/_workspace:$GOPATH

RUN go build
EXPOSE 3000
CMD ["./counter"]
