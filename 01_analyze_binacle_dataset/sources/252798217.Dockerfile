FROM delhomme/upscb-r-base  
MAINTAINER Nicolas Delhomme (nicolas.delhomme@umu.se)  
  
#########  
### Aptitude packages  
#########  
RUN apt-get update  
RUN apt-get install -y gdebi-core sudo libssl-dev && \  
mkdir build  
WORKDIR /build  
  
#########  
### Rstudio  
#########  
RUN wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb && \  
gdebi -n rstudio-server-1.1.423-amd64.deb  
  
#########  
### Cleanup  
#########  
WORKDIR /  
RUN rm -rf build  
  
#########  
### supervisord  
#########  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
EXPOSE 8787  
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]  

