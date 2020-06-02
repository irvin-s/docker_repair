FROM atlassianlabs/docker-node-jdk-chrome-firefox  
  
# Install Debian packages  
RUN apt-get update && \  
apt-get install -y git rsync && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

