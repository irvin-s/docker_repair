# godep: build  
#  
# docker build -t="bioshrek/golang-godep:1.4.2" .  
FROM golang:1.4.2  
MAINTAINER Huan Wang <shrekwang1@gmail.com>  
  
RUN go get github.com/tools/godep  

