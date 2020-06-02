FROM node:8.1.0-slim  
  
COPY package.json yarn.lock /srv/app/  
  
RUN cd /srv/app \  
&& yarn install --production \  
&& yarn clean \  
&& yarn cache clean  
  
COPY . /srv/app  
  
WORKDIR /srv/app  
  
CMD ["node", "app.js"]

