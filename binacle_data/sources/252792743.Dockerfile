FROM danielguerra/dockergui  
  
#########################################  
## ENVIRONMENTAL CONFIG ##  
#########################################  
# Set environment variables  
# User/Group Id gui app will be executed as default are 99 and 100  
ENV USER_ID=99  
ENV GROUP_ID=100  
# Gui App Name default is "GUI_APPLICATION"  
ENV APP_NAME FIREFOX  
  
# Default resolution, change if you like  
ENV WIDTH=1280  
ENV HEIGHT=720  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
#########################################  
## REPOSITORIES AND DEPENDENCIES ##  
#########################################  
  
RUN add-apt-repository ppa:nilarimogard/webupd8  
RUN apt-get update  
  
# Install packages needed for app  
#########################################  
## GUI APP INSTALL ##  
#########################################  
# Install steps for X app  
RUN apt-get -yy install browser-plugin-freshplayer-pepperflash firefox  
# Copy X app start script to right location  
COPY startapp.sh /startapp.sh  
  
#########################################  
## EXPORTS AND VOLUMES ##  
#########################################  
# Place whater volumes and ports you want exposed here:

