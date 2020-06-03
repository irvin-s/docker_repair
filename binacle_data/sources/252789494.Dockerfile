FROM ubuntu:16.04  
MAINTAINER Dao Anh Dung <dung13890@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install packages  
ADD provision.sh /provision.sh  
  
RUN chmod +x /*.sh  
  
RUN ./provision.sh  
  
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf  
  
RUN usermod -u 1000 www-data  
  
CMD ["/usr/bin/supervisord"]  
  
WORKDIR /var/www/app  
  
EXPOSE 9000  

