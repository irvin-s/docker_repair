FROM golang:1.8-alpine  
MAINTAINER Eduardo Sousa <ecsousa@gmail.com>  
WORKDIR /go/src  
RUN apk add git --no-cache && \  
go get -u github.com/pyed/deluge-telegram && \  
apk del git && \  
rm -rf /go/src/ /usr/local/go/pkg /usr/local/go/src  
CMD /go/bin/deluge-telegram -url=$DELUGE_URL  

