FROM node:7.9.0-alpine  
  
ENV APP_SRC=.  
ENV APP_HOME=/usr/src/app  
  
# Create app directory and install packages  
RUN mkdir -p $APP_HOME  
COPY $APP_SRC/package.json $APP_HOME  
WORKDIR $APP_HOME  
RUN npm install  
  
# Copy js files and build  
COPY $APP_SRC $APP_HOME  
COPY $APP_SRC/src/settings.default.js $APP_HOME/src/settings.js  
RUN npm run build -- --release  
  
CMD [ "node", "build/server.js" ]  

