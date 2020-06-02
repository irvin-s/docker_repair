FROM mhart/alpine-node:latest  
LABEL maintainer="0x142857@gmail.com"  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git openssh vim  

