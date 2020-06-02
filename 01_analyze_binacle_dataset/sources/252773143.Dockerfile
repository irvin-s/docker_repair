FROM golang:latest  
ENV APPDIR /go/src/github.com/bfosberry/kong-node-exporter  
RUN mkdir -p $APPDIR  
ADD . $APPDIR  
WORKDIR $APPDIR  
RUN go build -o main ./cmd  
CMD ["/go/src/github.com/bfosberry/kong-node-exporter/main"]  
EXPOSE 8080  

