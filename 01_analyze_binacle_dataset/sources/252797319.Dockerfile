FROM cloyne/powerdns  
  
MAINTAINER Mitar <mitar.docker@tnode.com>  
  
EXPOSE 53/udp 53/tcp  
  
COPY ./etc /etc  
  
RUN mkdir -p /etc/powerdns/bind && \  
chown pdns:pdns /etc/powerdns/bind  

