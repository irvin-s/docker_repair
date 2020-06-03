FROM node:wheezy  
ENV APP_HOME /app/  
ENV TEMP_NPM /temp  
  
RUN mkdir $APP_HOME  
WORKDIR $TEMP_NPM  
RUN yarn global add @angular/cli  
COPY package.json $TEMP_NPM  
RUN npm install --silent && cp -a $TEMP_NPM/node_modules $APP_HOME  
COPY ./ $APP_HOME  
  
WORKDIR $APP_HOME  
RUN npm run build:prod  
  
FROM nginx:alpine  
COPY \--from=0 /app/dist/ /usr/share/nginx/html  
COPY vhost.conf /etc/nginx/conf.d/default.conf  
EXPOSE 80  

