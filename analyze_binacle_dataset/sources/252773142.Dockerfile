FROM golang:latest  
ENV APPDIR /go/src/github.com/bfosberry/go-http-logger  
RUN mkdir -p $APPDIR  
ADD . $APPDIR  
WORKDIR $APPDIR  
RUN go build -o main ./cmd  
CMD ["/go/src/github.com/bfosberry/go-http-logger/main"]  
EXPOSE 8090

