FROM alpine:latest  
  
MAINTAINER Scott Markwell <scott@blurryworks.com>  
  
RUN apk update && apk add rsync  

