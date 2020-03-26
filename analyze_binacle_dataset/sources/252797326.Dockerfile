FROM clubcedille/debian  
  
MAINTAINER Michael Faille <michael@faille.io>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80 443  

