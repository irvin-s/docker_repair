FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add alpine-sdk --no-cache && \  
go get github.com/mdlayher/edgemax_exporter && \  
go get github.com/axw/gocov/gocov && \  
go get github.com/mattn/goveralls && \  
go get golang.org/x/tools/cmd/cover && \  
go get -t -v ./...  
  
FROM alpine:latest  
COPY \--from=build /go/bin/edgemax_exporter /go/bin/edgemax_exporter  
EXPOSE 9132  
CMD /go/bin/edgemax_exporter $ARGUMENTS  

