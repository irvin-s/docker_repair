FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get github.com/nlamirault/pihole_exporter && \  
go install github.com/nlamirault/pihole_exporter  
  
FROM alpine:latest  
COPY \--from=build /go/bin/pihole_exporter /go/bin/pihole_exporter  
EXPOSE 9311  
CMD /go/bin/pihole_exporter -pihole $PiHole  

