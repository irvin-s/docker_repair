FROM alpine:3.1  
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>  
  
COPY nginx-1.6.2-r2.apk /tmp/  
RUN apk update -v && \  
apk add -v --allow-untrusted /tmp/nginx-1.6.2-r2.apk  
RUN mkdir /tmp/nginx  
  
ENTRYPOINT ["/usr/sbin/nginx"]  

