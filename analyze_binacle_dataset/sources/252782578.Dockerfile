FROM golang:1.7  
MAINTAINER Hugo González Labrador  
  
ADD . /go/src/github.com/clawio/clawiod  
WORKDIR /go/src/github.com/clawio/clawiod  
  
RUN go get ./...  
RUN go install  
  
CMD /go/bin/clawiod -conf /go/src/github.com/clawio/clawiod/clawiod.conf  

