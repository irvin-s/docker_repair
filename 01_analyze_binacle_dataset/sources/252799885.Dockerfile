FROM golang:1.8-alpine  
  
MAINTAINER Steve Azzopardi <steve@digital-realms.net>  
  
# Install Glide Dependencies  
RUN apk update && \  
apk upgrade && \  
apk add --no-cache bash git openssh curl  
  
# Install Glide  
RUN curl https://glide.sh/get | sh

