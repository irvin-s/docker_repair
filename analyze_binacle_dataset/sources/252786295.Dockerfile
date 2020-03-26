FROM prom/blackbox-exporter  
MAINTAINER "The Doalitic Team" <devops@doalitic.com>  
  
RUN mkdir -p /etc/blackbox  
ADD blackbox.yml /etc/blackbox/  
  
CMD [ "-config.file=/etc/blackbox/blackbox.yml" ]  

