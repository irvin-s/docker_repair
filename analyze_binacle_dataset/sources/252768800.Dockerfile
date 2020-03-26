FROM ubuntu:16.04  
RUN apt -y update; apt -y install software-properties-common; \  
add-apt-repository -y ppa:freeradius/stable  
RUN apt -y update; apt install -y freeradius=2.2.9-ppa1~xenial \  
freeradius-mysql freeradius-postgresql freeradius-utils \  
mysql-client-core-5.7 curl gettext-base  
  
EXPOSE 1812/udp 1813/udp  
  
COPY freeradius/ /etc/freeradius/  
  
CMD /usr/sbin/freeradius -X  

