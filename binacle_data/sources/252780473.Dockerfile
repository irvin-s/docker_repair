FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
go get -u github.com/pyed/rtelegram  
  
FROM alpine:latest  
COPY \--from=build /go/bin/rtelegram /usr/local/bin/rtelegram  
RUN apk add ca-certificates --no-cache  
CMD /usr/local/bin/rtelegram -url=$RT_URL  

