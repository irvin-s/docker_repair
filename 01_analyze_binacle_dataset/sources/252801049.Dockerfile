FROM golang:1.8-alpine  
  
ENV ROOT /go/src/github.com/docker/registry-china  
  
RUN apk add --no-cache make bash  
  
COPY vendor $ROOT/vendor  
COPY pacer $ROOT/pacer  
COPY lib $ROOT/lib  
  
WORKDIR $ROOT/pacer  
  
RUN make PREFIX=/go binary  
  
CMD ["./pacer"]  
  

