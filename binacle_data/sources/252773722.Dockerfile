FROM registry:2  
MAINTAINER Jeff Nickoloff "jeff@allingeek.com"  
CMD ["/etc/docker/registry/config.yml"]  
COPY config.yml /etc/docker/registry/config.yml  

