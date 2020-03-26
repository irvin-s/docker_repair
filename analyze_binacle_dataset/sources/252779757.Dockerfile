FROM node:wheezy  
  
ENV APP_HOME /app/  
ENV TEMP_NPM /temp  
  
RUN mkdir $APP_HOME  
  
# caching npm packages  
WORKDIR $TEMP_NPM  
COPY package.json $TEMP_NPM  
RUN npm config set registry https://registry.npmjs.org/ && npm install pm2 -g  
RUN npm install --silent && cp -a $TEMP_NPM/node_modules $APP_HOME  
  
WORKDIR $APP_HOME  
  
COPY ./ $APP_HOME  
  
RUN npm run build  
  
EXPOSE 3000  
CMD ["pm2", "start", "processes.json", "--no-daemon"]  

