FROM cloudobjects/php-app-base  
MAINTAINER "Lukas Rosenstock"  
# Install crontabs and gearman  
RUN yum -y install gearmand crontabs  
  
# Install supervisord  
RUN curl https://bootstrap.pypa.io/ez_setup.py -o - | python \  
&& easy_install supervisor  
  
# Set up starter script  
ADD start.sh /tmp/  
  
# Expose Gearman port  
EXPOSE 4730  
# Launch starter script  
CMD ["/bin/sh", "/tmp/start.sh"]  

