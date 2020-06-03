FROM ubuntu-debootstrap:14.04  
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
RUN apt-get update  
RUN apt-get dist-upgrade -yq  
RUN apt-get install uhub pwgen -yq  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
EXPOSE 1511  
WORKDIR /root  
  
VOLUME ["/data"]  
  
CMD ["/start.sh"]  

