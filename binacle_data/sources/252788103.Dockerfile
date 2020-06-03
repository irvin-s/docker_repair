FROM golang:1.5  
MAINTAINER Guillaume J. Charmes <guillaume@charmes.net>  
  
ENV APP_DIR $GOPATH/src/github.com/creack/sink  
WORKDIR $APP_DIR  
  
ADD . $APP_DIR  
RUN go build  
  
ENTRYPOINT ["./sink"]  

