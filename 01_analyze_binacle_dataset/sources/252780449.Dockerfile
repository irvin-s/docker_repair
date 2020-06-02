FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get -u github.com/mdlayher/apcupsd_exporter && \  
go get -t -v ./...  
  
FROM alpine:latest  
COPY \--from=build /go/bin/apcupsd_exporter /usr/local/bin/apcupsd_exporter  
EXPOSE 9162  
CMD /usr/local/bin/apcupsd_exporter -apcupsd.addr $APCUPSDADDR  

