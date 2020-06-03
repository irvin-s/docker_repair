FROM golang:1.7  
MAINTAINER CommercialTribe <engineering@commercialtribe.com>  
  
ADD . $GOPATH/src/github.com/CommercialTribe/kube-auth-github  
WORKDIR $GOPATH/src/github.com/CommercialTribe/kube-auth-github  
  
# Install  
RUN go install  
RUN rm `which go`  
  
# Config  
ENV PORT 8989  
ENV GIN_MODE release  
  
EXPOSE $PORT  
  
CMD [ "kube-auth-github" ]  

