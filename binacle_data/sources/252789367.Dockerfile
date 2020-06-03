FROM centos:latest  
MAINTAINER duffqiu@gmail.com  
  
  
ADD confdinit /usr/bin/confdinit  
  
RUN chmod +x /usr/bin/confdinit  
  
VOLUME /etc/confd/conf.d/  
  
VOLUME /etc/confd/templates/  
  
ENTRYPOINT [ "/usr/bin/confdinit" ]  
  

