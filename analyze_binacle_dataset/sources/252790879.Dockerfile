FROM golang:1.7  
MAINTAINER Cultureamp IS Team <is_team@cultureamp.com>  
  
COPY . /go/src/github.com/cultureamp/aws-nquire  
  
RUN go get -u github.com/aws/aws-sdk-go  
RUN go get -v github.com/spf13/cobra/cobra  
  
RUN go build github.com/cultureamp/aws-nquire  
  
RUN go test github.com/cultureamp/aws-nquire/...  
  
RUN cp ./aws-nquire /usr/local/bin  
  
ENTRYPOINT ["/usr/local/bin/aws-nquire"]  

