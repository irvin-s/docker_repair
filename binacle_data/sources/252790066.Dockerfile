FROM golang:alpine  
RUN apk update && \  
apk add git && \  
go get github.com/bitly/oauth2_proxy && \  
apk del git  
WORKDIR /go/bin  
ENTRYPOINT ["oauth2_proxy"]  

