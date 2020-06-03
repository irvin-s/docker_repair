# Dockerfile to build the Docker binary, but more 
# importantly save off the package .a files for use with 
# nsf/gocode (https://github.com/nsf/gocode) autocomplete
# plugin use in vim (or other editors)
FROM golang:1.5.3
MAINTAINER estesp@gmail.com

# Install docker daemon build dependencies
RUN apt-get update && apt-get install -y \
	libdevmapper-dev \
	btrfs-tools \
	libsqlite3-dev

WORKDIR /go
RUN mkdir -p src/github.com/docker

# clone current master and put in /go/github.com/docker/docker
RUN cd /go/src/github.com/docker && git clone https://github.com/docker/docker

# set up proper $GOPATH for Docker build
ENV GOPATH /go:/go/src/github.com/docker/docker/vendor

COPY dockompleter.sh /

# see dockompleter.sh for information on how to use
# a bind mount to get the output .a files in the right
# $GOPATH/pkg dir on your host system
CMD [ "/dockompleter.sh" ]
