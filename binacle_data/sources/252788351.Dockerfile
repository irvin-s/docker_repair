FROM golang:1.4.2  
RUN go get github.com/tools/godep  
ADD . /go/src/github.com/remind101/emp  
WORKDIR /go/src/github.com/remind101/emp  
RUN godep go build  
RUN mv emp /go/bin/  
  
ENTRYPOINT ["/go/bin/emp"]  

