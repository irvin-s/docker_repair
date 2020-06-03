FROM debian:latest  
MAINTAINER Biomedia <none@mail.invalid>  
  
RUN apt-get update && apt-get --yes install bind9  
COPY named-add.conf /tmp  
RUN cat /tmp/named-add.conf >> /etc/bind/named.conf.options  
  
EXPOSE 53  
ENTRYPOINT /usr/sbin/named -f  
  

