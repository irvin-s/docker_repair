FROM golang:1.8  
MAINTAINER Julien Poulton <julien@codingame.com>  
COPY entrypoint.sh /  
COPY build.sh /build  
RUN go get github.com/tools/godep  
ENTRYPOINT ["/entrypoint.sh"]

