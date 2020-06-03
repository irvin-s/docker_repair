FROM alpine:3.3  
MAINTAINER Herman Fries  
  
RUN apk add keepalived --update-cache --repository \  
http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted  
  
RUN apk add --update \  
kmod net-tools perl bash \  
&& rm -rf /var/cache/apk/*  
  
COPY run.sh /run.sh  
COPY keepalived.conf /etc/keepalived/keepalived.conf  
  
ENTRYPOINT [ "/run.sh" ]  

