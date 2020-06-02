FROM jupyter/datascience-notebook  
MAINTAINER Behzad Samadi <behzad@mechatronics3d.com>  
  
USER root  
  
# Install LXDE, VNC server, XRDP and Firefox  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \  
lxde-core \  
lxterminal \  
tightvncserver \  
xrdp  
  
# Open port 5901  
EXPOSE 5901  
# Set default password  
COPY password.txt .  
RUN cat password.txt password.txt | vncpasswd && \  
rm password.txt  
  
# Set XDRP to use TightVNC port  
RUN sed -i '0,/port=-1/{s/port=-1/port=5901/}' /etc/xrdp/xrdp.ini  
  
# Copy VNC script that handles restarts  
COPY vnc.sh /opt/  
CMD ["/opt/vnc.sh"]  
  
USER $NB_USER  

