FROM golang:alpine AS build  
MAINTAINER b3vis  
RUN apk add git --no-cache && \  
git clone https://github.com/ircop/smtp2tg /go/src/smtp2tg && \  
go get gopkg.in/telegram-bot-api.v4 && \  
go get github.com/spf13/viper  
RUN go build /go/src/smtp2tg/main.go  
  
FROM alpine:latest  
COPY \--from=build /go/main /usr/local/bin/smtp2tg  
RUN apk add ca-certificates --no-cache  
EXPOSE 25  
VOLUME /config  
CMD ["/usr/local/bin/smtp2tg","-c","/config/smtp2tg.toml"]  

