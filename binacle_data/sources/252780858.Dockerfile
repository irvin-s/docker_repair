FROM python:2.7  
MAINTAINER Peter Rauhut<baffling.bear@gmail.com>  
  
# Builds a base image that inherits from the python2.7 image and  
# installs supervisord with some base configurations to it.  
RUN apt-get update \  
&& apt-get install -y supervisor \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
CMD ["/usr/bin/supervisord"]  

