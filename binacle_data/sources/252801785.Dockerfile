FROM alpine:3.4  
MAINTAINER "ECUSTXX" <13673460778@163.com>  
  
ENV PORT **NULL**  
ENV PASS **NULL**  
  
COPY repositories /etc/apk/repositories  
  
RUN apk add --no-cache curl py-pip python curl python-dev pwgen \  
&& pip install shadowsocks setuptools \  
&& mkdir /etc/shadowsocks  
  
COPY Start /Start  
  
EXPOSE 9621  
CMD ["sh","/Start"]  

