FROM golang:1.7-alpine  
MAINTAINER b3vis  
WORKDIR /go/src  
RUN apk add git --no-cache && \  
git clone --depth=50 https://github.com/mdlayher/rtorrent_exporter.git && \  
cd /go/src/rtorrent_exporter && \  
go get github.com/axw/gocov/gocov && \  
go get github.com/mattn/goveralls && \  
go get golang.org/x/tools/cmd/cover && \  
go get github.com/golang/lint/golint && \  
go get -t -v ./... && \  
go get -d ./... && \  
go build ./... && \  
apk del git && \  
rm -rf /go/src/  
EXPOSE 9135  
CMD /go/bin/rtorrent_exporter -rtorrent.addr $RTORRENTADDR  

