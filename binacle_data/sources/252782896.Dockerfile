FROM selenium/node-chrome-debug  
MAINTAINER David Soff <david@soff.nl>  
  
USER root  
  
ENV PROXY_SERVER ""  
#=================================  
# Chrome Launch Script Modication  
#=================================  
COPY chrome_launcher.sh /opt/google/chrome/google-chrome  
RUN chmod +x /opt/google/chrome/google-chrome

