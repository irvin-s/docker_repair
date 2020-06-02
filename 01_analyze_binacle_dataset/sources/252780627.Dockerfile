FROM node:8.11.1  
# The base node image sets a very verbose log level.  
#ENV NPM_CONFIG_LOGLEVEL warn  
# In your Dockerfile.  
COPY . .  
  
#RUN npm install webpack  
#RUN npm install webpack-cli -D  
RUN npm install  
RUN npm run build --production  
RUN npm install serve -g  
  
ENV NODE_ENV=production  
CMD serve -s dist  
#CMD npm run start  
EXPOSE 5000  

