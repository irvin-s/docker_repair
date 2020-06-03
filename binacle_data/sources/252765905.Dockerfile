FROM 4armed/apache-php:latest  
MAINTAINER Marc Wickenden <marc@4armed.com>  
  
# Install packages  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get -y install libapache2-modsecurity && \  
rm -rf /var/lib/apt/lists/*  
  
COPY modsecurity.conf /etc/modsecurity/modsecurity.conf  

