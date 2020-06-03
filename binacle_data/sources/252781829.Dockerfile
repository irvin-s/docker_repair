FROM node:6-alpine  
WORKDIR /home/node  
USER node  
COPY index.js package.json ./  
RUN npm install  
ENTRYPOINT ["node", "index.js"]

