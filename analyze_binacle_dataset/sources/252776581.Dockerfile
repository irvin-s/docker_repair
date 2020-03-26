FROM selenium/standalone-firefox  
  
MAINTAINER Robert Horvath <robert.horvath@catalysts.cc>  
  
USER root  
  
RUN apt-get update -qq && \  
apt-get install -qq -y \  
x11vnc \  
xvfb \  
libav-tools \  
tcpdump && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
USER seluser  
  
ADD entrypoint.sh .  
  
ENTRYPOINT ["bash", "entrypoint.sh"]  
  
EXPOSE 4444 5900  

