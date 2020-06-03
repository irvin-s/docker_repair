FROM golang:1.6  
RUN mkdir -p /go/src/fknsrs.biz/p/cfx  
  
WORKDIR /go/src/fknsrs.biz/p/cfx  
  
ADD vendor vendor/  
ADD *.go ./  
  
RUN go install  
  
ENTRYPOINT ["/go/bin/cfx"]  

