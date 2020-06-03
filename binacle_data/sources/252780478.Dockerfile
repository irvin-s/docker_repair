FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get -u github.com/andmarios/sensor_exporter  
  
FROM alpine:latest  
COPY \--from=build /go/bin/sensor_exporter /usr/local/bin/sensor_exporter  
EXPOSE 9091  
CMD /usr/local/bin/sensor_exporter $ARGUMENTS  

