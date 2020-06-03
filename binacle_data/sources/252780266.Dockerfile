FROM golang:1-alpine  
ADD . /  
RUN apk add \--no-cache git openssh-client musl-dev gcc curl && \  
go get -u github.com/golang/dep/cmd/dep && \  
go get -u github.com/go-swagger/go-swagger/cmd/swagger && \  
go get -u github.com/derekparker/delve/cmd/dlv  

