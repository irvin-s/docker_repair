FROM node:8.1.2-alpine  
  
# Install packages  
RUN apk --no-cache add \  
tini g++ gcc make bash gnupg paxctl python linux-headers  
  
# Use Tini as the init process  
ENTRYPOINT ["/sbin/tini", "--"]  
  
# Make directories  
RUN mkdir /app /data  
WORKDIR /app  
  
# Switch user  
RUN chown -R node:node /app /data  
USER node  
  
# Install npm-register  
RUN npm install npm-register@2.2.0  
ENV PATH="/app/node_modules/.bin:$PATH"  
# Configure local filesystem storage for npm-register  
ENV NPM_REGISTER_STORAGE=fs \  
NPM_REGISTER_FS_DIRECTORY=/data  
  
# Start npm-register  
EXPOSE 3000  
CMD [ "npm-register", "start" ]  

