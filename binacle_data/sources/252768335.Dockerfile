FROM alpine:3.5  
MAINTAINER https://github.com/adorsys/dockerhub-alpine-base  
  
  
RUN apk -q --no-cache add curl wget ca-certificates && update-ca-certificates  

