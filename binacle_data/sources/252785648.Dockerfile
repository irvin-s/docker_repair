FROM golang:1.7  
MAINTAINER CommercialTribe <engineering@commercialtribe.com>  
  
ADD . $GOPATH/src/github.com/CommercialTribe/kube-ssl  
WORKDIR $GOPATH/src/github.com/CommercialTribe/kube-ssl  
  
# Install  
RUN go install  
RUN rm `which go`  
  
CMD [ "kube-ssl" ]  

