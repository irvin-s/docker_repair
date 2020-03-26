FROM node:latest  
  
# Create app directory  
RUN mkdir -p /usr/src/pagespeed-insights-bot  
WORKDIR /usr/src/pagespeed-insights-bot  
  
ENV NODE_ENV production  
  
# Install app dependencies  
COPY package.json /usr/src/pagespeed-insights-bot/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/pagespeed-insights-bot  
  
CMD [ "npm", "start" ]  

