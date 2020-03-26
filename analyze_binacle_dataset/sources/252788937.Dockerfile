FROM ubuntu:16.04  
# Set noninteractive mode for apt-get  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get -y install supervisor postfix sasl2-bin opendkim opendkim-tools  
  
ADD assets/install.sh /opt/install.sh  
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf  

