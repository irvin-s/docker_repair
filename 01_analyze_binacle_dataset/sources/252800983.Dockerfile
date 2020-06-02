FROM golang:1.6-onbuild  
RUN mkdir -p /go/src/github.com/dooman87/go-intro  
ADD . /go/src/github.com/dooman87/go-intro  
ADD entrypoint.sh /  
RUN chmod 755 /entrypoint.sh  
  
WORKDIR /  
ENTRYPOINT ./entrypoint.sh

