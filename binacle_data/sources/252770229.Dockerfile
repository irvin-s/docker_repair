FROM node:0.11-slim  
RUN npm install -g minimist  
RUN npm install -g request  
RUN npm install -g dockerode  
RUN npm install -g docker-host  
ENV NODE_PATH /usr/local/lib/node_modules  
ADD index.js /usr/local/bin/rainbow-dock-populator  
ENTRYPOINT ["rainbow-dock-populator"]  

