FROM hurricane/dockergui:xvnc  
MAINTAINER Lime Technology <erics@lime-technology.com>  
#Based on the work of gfjardim <gfjardim@gmail.com>  
#########################################  
## ENVIRONMENTAL CONFIG ##  
#########################################  
# Set correct environment variables  
ENV APP_NAME="CrashPlanDesktop" WIDTH=1000 HEIGHT=650  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
#########################################  
## FILES, SERVICES AND CONFIGURATION ##  
#########################################  
# Add config.sh to execute during container startup  
COPY config.sh /etc/my_init.d/00_config.sh  
  
# Add services to runit  
COPY crashplan.sh /etc/service/crashplan/run  
  
#########################################  
## GUI APP INSTALL ##  
#########################################  
# Install steps for X app  
COPY install.sh /tmp/  
RUN chmod +x /tmp/install.sh; sync && /tmp/install.sh && rm /tmp/install.sh  
  
#########################################  
## EXPORTS AND VOLUMES ##  
#########################################  
  
VOLUME /config  
VOLUME /data  
EXPOSE 4242 8080

