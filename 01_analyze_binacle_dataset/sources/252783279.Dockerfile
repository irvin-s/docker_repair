# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
# NOTE: DO *NOT* EDIT THIS FILE. IT IS GENERATED.  
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE  
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
FROM selenium/node-chrome-debug:3.4.0-dysprosium  
LABEL authors=SeleniumHQ  
  
USER root  
  
#==============  
# Install VNC  
#==============  
RUN apt-get update -qqy \  
&& apt-get -qqy install \  
tightvncserver \  
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*  
  
  
ENV USER root  
#==================  
# Set default password for VNC server  
#==================  
ENV VNC_PWD vncpasswd  
#==================  
# Start VNC server  
#==================  
  
# Specific the port of selenium hub  
ENV NODE_PORT 4444  
  
COPY entry_point.sh /opt/bin/entry_point.sh  
RUN chmod +x /opt/bin/entry_point.sh  
  
USER seluser  
  
EXPOSE 4444  
EXPOSE 5901  
  
COPY extension/ChangeUA.crx opt/selenium/ChangeUA.crx

