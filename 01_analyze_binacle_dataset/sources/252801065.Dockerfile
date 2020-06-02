FROM node:6  
WORKDIR /root  
RUN apt-get update && \  
apt-get install git  
ENV HOME /root  
COPY bower.json ./  
COPY index.html ./  
COPY socket.io.js ./  
COPY manifest.json ./  
COPY package.json ./  
COPY polymer.json ./  
COPY server.js ./  
RUN npm install  
RUN npm install -g bower  
RUN bower install --allow-root  
COPY images ./images/  
COPY src ./src/  
COPY test ./test/  
RUN npm install -g polymer-cli --unsafe-perm=true  
RUN polymer build  
EXPOSE 8080  
CMD [ "node", "server.js" ]  

