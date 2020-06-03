FROM ubuntu:14.04.4  
MAINTAINER AnShun Liu <asliu823@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install packages  
ADD provision.sh /provision.sh  
ADD serve /usr/local/bin/serve  
  
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf  
  
RUN chmod +x /*.sh  
RUN chmod +x /usr/local/bin/serve  
RUN ./provision.sh  
RUN rm /provision.sh  
  
EXPOSE 80 443 22 35729 9876  
CMD ["/usr/bin/supervisord"]

