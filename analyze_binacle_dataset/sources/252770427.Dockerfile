FROM jolicode/nvm  
  
# Install Ubuntu packages  
RUN sudo apt-get update && \  
sudo apt-get install -y git xvfb firefox chromium-browser && \  
sudo apt-get clean && \  
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

