FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get -u github.com/mdlayher/unifi_exporter && \  
go get -t -v ./...  
  
FROM alpine:latest  
COPY \--from=build /go/bin/unifi_exporter /usr/local/bin/unifi_exporter  
EXPOSE 9130  
VOLUME /config  
CMD /usr/local/bin/unifi_exporter -config.file /config/config.yml  

