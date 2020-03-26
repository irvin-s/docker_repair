FROM ubuntu-debootstrap:14.04  
MAINTAINER docker@vmaurik.nl  
  
RUN apt-get update && apt-get clean  
RUN apt-get install -y squid3 && apt-get clean  
ADD squid.conf /etc/squid3/squid.conf  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
RUN mkdir /var/cache/squid  
RUN chown proxy:proxy /var/cache/squid  
RUN /usr/sbin/squid3 -N -z -F  
  
EXPOSE 3128  
CMD ["/start.sh"]  

