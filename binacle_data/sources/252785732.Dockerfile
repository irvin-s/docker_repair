# Base image  
FROM library/node:7.4.0-slim  
  
# Maintainer  
MAINTAINER Compiax (Pty) Ltd. <admin@compiax.io>  
  
# Set Workdir  
WORKDIR /home/node/platypus-api  
  
# Get package.json  
COPY package.json .  
RUN chown -R node .  
  
# Install dependencies  
RUN \  
npm install -g \  
mocha \  
nodemon  
  
USER node  
  
RUN \  
npm install && \  
npm cache clean  
  
# Get source  
COPY . .  
  
# Expose ports  
EXPOSE 3000  
EXPOSE 3002  
# Command  
CMD ["npm", "start"]  

