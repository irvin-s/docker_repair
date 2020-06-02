FROM golang:alpine  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get github.com/inCaller/prometheus_bot && \  
go install github.com/inCaller/prometheus_bot && \  
apk del git --no-cache && \  
rm -rf /go/src/*  
EXPOSE 9087  
CMD /go/bin/prometheus_bot -c /config/config.yaml  

