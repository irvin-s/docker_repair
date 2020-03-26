FROM node:5.0.0-wheezy  
  
RUN apt-get update && \  
apt-get install -y mysql-client-5.5 curl && \  
apt-get clean  
  
RUN curl -sf \  
-o /tmp/ryocdr.tar.gz \  
-L https://github.com/antirek/ryocdr/archive/v0.0.11.tar.gz && \  
mkdir /tmp/ryocdr && \  
tar -xzf /tmp/ryocdr.tar.gz -C /tmp/ryocdr --strip-components=1 && \  
cd /tmp/ryocdr  
  
WORKDIR /tmp/ryocdr  
  
RUN npm install && \  
npm install bower -g && \  
bower install --allow-root && \  
mkdir -p /tmp/ryocdr/public/js/build && \  
npm run build  
  
CMD node /tmp/ryocdr/app.js

