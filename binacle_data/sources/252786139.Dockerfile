FROM fedora:23  
MAINTAINER Diogo Oliveira de Melo <dmelo87@gmail.com>  
  
  
EXPOSE 8888  
ADD ./ /you2better  
WORKDIR /you2better  
  
# install packages  
RUN ./docker-setup.sh  
  
CMD ["/usr/bin/php", "-S", "0.0.0.0:8888", "-t", "/you2better/"]  

