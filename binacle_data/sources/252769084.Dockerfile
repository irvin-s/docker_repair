#  
# We are using a golang standard image and compile it ourself.  
# We are not using the golang onbuild image, because our  
# application is located in cmd/perseus/main.go and not in the  
# root dir, like many other apps.  
#  
FROM golang:1.8  
MAINTAINER Andy Grunwald <andygrunwald@gmail.com>  
  
COPY . /go/src/github.com/andygrunwald/perseus  
  
RUN mkdir -p /var/config \  
&& cp /go/src/github.com/andygrunwald/perseus/.docker/*.json /var/config \  
&& cd /go/src/github.com/andygrunwald/perseus \  
&& go get -v ./... \  
&& CGO_ENABLED=0 go install github.com/andygrunwald/perseus/cmd/perseus \  
&& mv /go/bin/perseus /perseus \  
&& rm -rf /go  
  
ENTRYPOINT ["/perseus"]

