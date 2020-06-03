# Version 1.0  
FROM abh1nav/baseimage:latest  
  
MAINTAINER Abhinav Ajgaonkar <abhinav316@gmail.com>  
  
RUN \  
cd /tmp; \  
wget https://packagecloud.io/install/repositories/basho/riak/script.deb; \  
bash script.deb; \  
rm script.deb; \  
apt-get install -y -qq riak=2.0.0-1; \  
mkdir -p /etc/service/riak  
  
COPY run /etc/service/riak/  
  
WORKDIR /root  
  
EXPOSE 8098 8087  
CMD ["/sbin/my_init"]  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

