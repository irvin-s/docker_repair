FROM google/cloud-sdk:latest  
RUN \  
curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -y nodejs && \  
npm install -g @angular/cli \--no-progress && \  
npm install -g swagger \--no-progress && \  
npm install -g loopback-cli \--no-progress && \  
npm install -g mocha \--no-progress && \  
npm install -g nodemon \--no-progress && \  
npm cache clean && \  
apt-get autoremove -y && \  
apt-get autoclean && \  
apt-get clean  
  
# start developing  

