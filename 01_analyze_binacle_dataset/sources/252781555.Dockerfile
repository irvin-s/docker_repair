# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
# NOTE: DO *NOT* EDIT THIS FILE. IT IS GENERATED.  
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE  
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
FROM baozhida/selenium-node-chrome:3.3.1  
MAINTAINER baozihda <baozihda88@126.com>  
  
USER root  
  
#=====  
# VNC  
#=====  
RUN apt-get update -qqy \  
&& apt-get -qqy install \  
x11vnc \  
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \  
&& mkdir -p /root/.vnc \  
&& x11vnc -storepasswd secret ~/.vnc/passwd  
  
#=========  
# fluxbox  
# A fast, lightweight and responsive window manager  
#=========  
RUN apt-get update -qqy \  
&& apt-get -qqy install \  
fluxbox \  
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*  
  
#==============================  
# Scripts to run Selenium Node  
#==============================  
COPY entry_point.sh /opt/bin/entry_point.sh  
RUN chmod +x /opt/bin/entry_point.sh  
  
EXPOSE 5900  

