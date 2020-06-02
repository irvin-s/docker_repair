FROM ubuntu:14.04  
MAINTAINER Grant Hutchinson <h.g.utchinson@gmail.com>  
  
ADD . /var/www/html/  
ADD bootup.sh /root/bootup.sh  
  
RUN apt-get update && \  
apt-get install -y apache2 php5 php5-mysql php5-curl curl wget git && \  
cd /var/www/html/ && \  
git submodule init && git submodule update && \  
chmod +x /root/bootup.sh && \  
rm ./bootup.sh && chmod 755 * -R && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80  
CMD ["/bin/bash", "/root/bootup.sh"]  

