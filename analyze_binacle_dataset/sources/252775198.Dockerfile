FROM beatee/webserver-symfony-base  
  
MAINTAINER Jan Klan <jan@beatee.org>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get upgrade -y \  
&& apt-get install -y nano mc  
  
###  
# Install xdebug  
###  
RUN apt-get install -y php-xdebug \  
&& phpenmod xdebug  
  
###  
# Configure xdebug  
###  
  
ENV XDEBUG_HOST 127.0.0.1  
ENV XDEBUG_PORT 9000  
ENV XDEBUG_REMOTE_MODE jit  
ENV XDEBUG_CONNECT_BACK 0  
  
###  
# Add dev-friendly setup files  
###  
ADD etc /etc  
  
RUN usermod -u 1000 www-data  
  
EXPOSE 9000  
  
###  
# Shrink image  
###  
RUN apt-get clean  

