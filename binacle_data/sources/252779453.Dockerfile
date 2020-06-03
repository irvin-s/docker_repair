FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get install -y curl python-software-properties && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y git-core python php-cli php-curl nodejs curl && \  
node -v && \  
npm -v && \  
npm install apigeetool -g \  
npm install openapi2apigee -g  
  
VOLUME /code  
WORKDIR /code  

