FROM node:6  
  
RUN cd /opt && git clone https://github.com/Cloudeity/orion.client  
WORKDIR /opt/orion.client/modules/orionode  
RUN npm install --prod && \  
npm prune --production && \  
chown -R node /opt/orion.client && \  
chgrp -R node /opt/orion.client  
  
USER node  
  
ENTRYPOINT ["node","server.js"]

