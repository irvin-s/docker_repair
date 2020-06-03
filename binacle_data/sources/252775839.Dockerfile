FROM node:alpine AS web-builder  
  
RUN mkdir -p build  
WORKDIR build  
COPY package*.json ./  
COPY webpack.config.js ./  
COPY src/ ./src  
  
RUN npm install  
RUN npm run build  
  
FROM tobi312/rpi-apache2  
COPY \--from=web-builder /build/dist/ /var/www  
COPY ./000-default.conf /etc/apache2/sites-available  
COPY ./mods-available /etc/apache2/mods-enabled

