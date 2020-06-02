FROM acdcjunior/ubuntu-chromedriver-java8  
  
MAINTAINER Antonio "acdc" Jr. <acdcjunior@gmail.com>  
  
# Base image changes user  
USER root  
  
# Install lsb_release (oraclejdk8)  
RUN \  
apt-get update && \  
apt-get install -y lsb-release && \  
apt-get clean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY start-xvfb-via-exec-tini.sh /usr/local/bin/start-xvfb-via-exec-tini  
  
# Define default command  
CMD ["bash"]  

