FROM golang:latest  
MAINTAINER Brandfolder <developers@brandfolder.com>  
  
# Add  
ADD . $GOPATH/src/github.com/brandfolder/shovel  
WORKDIR $GOPATH/src/github.com/brandfolder/shovel  
  
# Get Deps  
RUN go get  
  
# Run CMD  
ENTRYPOINT ["shovel"]  

