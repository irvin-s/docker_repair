FROM besn0847/ubuntu32  
MAINTAINER barrymac <barrymac@gmail.com>  
  
#########################################  
## ENVIRONMENTAL CONFIG ##  
#########################################  
  
# Set correct environment variables  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
ENV LC_ALL C.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
  
#########################################  
## FILES, SERVICES AND CONFIGURATION ##  
#########################################  
  
# Add services to runit  
ADD logitechmediaserver.sh /etc/service/logitechmediaserver/run  
RUN chmod +x /etc/service/*/run  
  
#########################################  
## EXPORTS AND VOLUMES ##  
#########################################  
  
VOLUME /config /music  
EXPOSE 3483 3483/udp 9000 9090  
  
#########################################  
## RUN INSTALL SCRIPT ##  
#########################################  
  
ADD install.sh /tmp/  
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh  
  
#########################################  
## RUN Slimserver ##  
#########################################  
  
CMD /etc/service/logitechmediaserver/run  

