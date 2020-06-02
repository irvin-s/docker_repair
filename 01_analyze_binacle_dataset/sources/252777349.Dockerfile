FROM node:7-slim  
  
MAINTAINER Cedric Gatay <c.gatay@code-troopers.com>  
  
RUN apt-get update \  
&& apt-get install -yq libpcap-dev vim git python make g++ \  
&& npm install -g node-dash-button request \  
&& apt-get clean \  
&& apt-get autoclean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
VOLUME /app  
WORKDIR /app  
  
ADD app.js /app/app.js  
  
ENV NODE_PATH=/usr/local/lib/node_modules \  
DASH_MAC='00:00:00:00:00:00' \  
MSG='' \  
EMOTICON='' \  
TOKEN='' \  
DURATION='5'  
CMD ["node", "app.js"]  

