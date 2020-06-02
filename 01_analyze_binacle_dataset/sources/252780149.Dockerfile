FROM ubuntu:14.04  
MAINTAINER Ayush Shanker <ayush@cloudinfra.in>  
  
# Install Apache, PHP5 and speedtest mini zip  
RUN apt-get update -qq \  
&& apt-get install -y wget unzip apache2 php5 php5-mysql php5-gd php5-mcrypt \  
&& wget http://c.speedtest.net/mini/mini.zip -O /tmp/mini.zip \  
&& mkdir -p /var/www/mini \  
&& unzip /tmp/mini.zip -d /var/www/ \  
&& cd /var/www/mini \  
&& mv index-php.html index.html \  
&& mv * ../ \  
&& mkdir -p /etc/apache2/conf.d/ \  
&& echo "ServerName localhost" | tee /etc/apache2/conf.d/fqdn \  
&& apt-get clean autoclean \  
&& apt-get autoremove -y \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}/* /tmp/* /var/tmp/*  
  
ADD entrypoint.sh /entrypoint.sh  
  
# Ports  
EXPOSE 80  
CMD ["sudo /entrypoint.sh"]  

