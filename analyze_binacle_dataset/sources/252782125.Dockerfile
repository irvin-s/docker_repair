FROM golang:alpine  
  
RUN apk --update add git  
RUN go get github.com/tools/godep  
  
ADD . /go/src/github.com/ciena/maas-flow  
RUN godep get github.com/ciena/maas-flow  
RUN go install github.com/ciena/maas-flow  
  
ENTRYPOINT ["/go/bin/maas-flow"]  

