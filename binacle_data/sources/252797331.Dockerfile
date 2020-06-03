FROM clubcedille/apache  
MAINTAINER Michael Faille <michael@faille.io>  
  
RUN apt-get update && \  
apt-get install -y php5 php-pear && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80 443  

