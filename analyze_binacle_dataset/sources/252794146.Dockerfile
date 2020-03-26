FROM ubuntu:16.04  
RUN apt-get update -y; \  
apt-get install -y apache2; \  
a2enmod cgi;  
ENTRYPOINT service apache2 start && /bin/bash  
EXPOSE 80

