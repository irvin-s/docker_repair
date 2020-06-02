FROM ubuntu:14.04  
  
# Run upgrades  
RUN apt-get update;\  
apt-get -y upgrade  
  
# Install dependencies  
RUN apt-get install -y software-properties-common  
  
# Install freeradius  
RUN add-apt-repository -y ppa:freeradius/stable-3.0;\  
apt-get update;\  
apt-get -y install freeradius freeradius-mysql freeradius-ldap  
  
CMD ["/usr/sbin/freeradius", "-X"]  

