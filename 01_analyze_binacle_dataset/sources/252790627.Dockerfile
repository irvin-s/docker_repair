FROM golang:1.8  
MAINTAINER Lei Xue <simon@hyper.sh>  
  
RUN mkdir -p /cron/src/github.com/hyperhq/gcron  
ADD . /cron/src/github.com/hyperhq/gcron/  
ENV GOPATH /cron/  
WORKDIR ${GOPATH}/src/github.com/hyperhq/gcron  
RUN go get github.com/tools/godep  
RUN /cron/bin/godep go build crond.go  
ENTRYPOINT ["./crond"]  
EXPOSE 34568  
CMD ["./crond"]  

