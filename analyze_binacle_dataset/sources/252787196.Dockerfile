FROM marcbachmann/libvips  
MAINTAINER Brendan Younger <brendan@brendanyounger.com>  
  
WORKDIR /image-server  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential && \  
curl -sL https://deb.nodesource.com/setup | sudo bash - && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs && \  
npm install -g image-resizer && \  
image-resizer new && \  
npm install  
  
RUN apt-get remove -y curl build-essential && \  
apt-get autoremove -y && \  
apt-get autoclean && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV NODE_ENV=production  
  
EXPOSE 3001  
ENTRYPOINT nodejs index.js  

