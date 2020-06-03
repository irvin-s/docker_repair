FROM golang:1.4.2  
MAINTAINER Dongju Jang <dongju@cosmos.io>  
  
ENV PATH /go/bin:$PATH  
  
RUN go get github.com/samalba/dockerclient  
  
ADD . /go/src/blackhole  
WORKDIR /go/src/blackhole  
  
RUN go install  
  
ENTRYPOINT /go/bin/blackhole

