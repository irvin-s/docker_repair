FROM alpine:latest  
MAINTAINER Alain Knaebel, <alain.knaebel@aknaebel.fr>  
  
RUN apk --update upgrade \  
&& apk add --update --no-cache bind \  
&& rm -rf /var/cache/apk/* \  
&& mkdir /etc/bind/zones  
  
EXPOSE 53/udp  
  
VOLUME /etc/bind/zones  
  
CMD /usr/sbin/named -u named -g -d 1  

