FROM alpine:3.5  
MAINTAINER Bryan Weaver <bryanweaver@outlook.com>  
  
RUN apk add --no-cache curl bash jq git  
  
ADD src/ /opt/resource/  
RUN chmod +x /opt/resource/*

