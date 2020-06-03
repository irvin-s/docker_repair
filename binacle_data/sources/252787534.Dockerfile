# Version: 1.0.0  
FROM alpine:3.6  
MAINTAINER Brock Research  
  
RUN apk add \--no-cache \  
ca-certificates  
  
RUN apk update  
  
RUN apk add tree=1.7.0-r0  
  
RUN apk add jq=1.5-r3  
  
RUN apk add su-exec=0.2-r0  
  
ENV PS1="\h:\w\> "  
  
CMD ["/bin/sh"]

