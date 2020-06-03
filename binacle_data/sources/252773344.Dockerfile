FROM ubuntu:trusty  
  
## Install the validator  
RUN apt-get update && \  
apt-get install -y curl && \  
curl -sL https://deb.nodesource.com/setup_4.x | bash - && \  
apt-get remove -y curl && \  
apt-get install -y nodejs && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g bids-validator@0.19.2  

