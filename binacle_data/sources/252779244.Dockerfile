FROM golang:1.4  
MAINTAINER Gabe Conradi <gabe@tumblr.com>  
COPY . /go/src/github.com/byxorna/collinsbot  
RUN go get github.com/tools/godep  
RUN cd /go/src/github.com/byxorna/collinsbot && godep go install  
ENTRYPOINT ["collinsbot"]  
CMD ["-h"]  
  

