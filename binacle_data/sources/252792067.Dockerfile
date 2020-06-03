FROM alpine:3.4  
MAINTAINER "Charlie Wang" <272876047@qq.com>  
  
ENV PASS **NULL**  
  
COPY repositories /etc/apk/repositories  
  
RUN apk add --no-cache curl py-pip python curl python-dev pwgen \  
&& pip install shadowsocks setuptools \  
&& mkdir /etc/shadowsocks  
  
COPY entrypoint /entrypoint  
  
EXPOSE 4444  
CMD ["sh","/entrypoint"]  

