FROM phusion/baseimage:0.9.15  
MAINTAINER needo <needo@superhero.org>  
  
#########################################  
## ENVIRONMENTAL CONFIG ##  
#########################################  
# Set correct environment variables  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
ENV LC_ALL C.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
#########################################  
## FILES, SERVICES AND CONFIGURATION ##  
#########################################  
# Add services to runit  
ADD couchpotato.sh /etc/service/couchpotato/run  
ADD edge.sh /etc/my_init.d/edge.sh  
  
RUN chmod +x /etc/service/*/run /etc/my_init.d/*  
  
#########################################  
## EXPORTS AND VOLUMES ##  
#########################################  
  
VOLUME /config  
EXPOSE 5050  
#########################################  
## RUN INSTALL SCRIPT ##  
#########################################  
  
ADD install.sh /tmp/  
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh  

