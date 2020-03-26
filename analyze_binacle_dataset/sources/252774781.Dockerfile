FROM node  
LABEL maintainer="Sebastian Limbach"  
  
RUN apt-get update \  
&& apt-get install -y build-essential nginx \  
&& echo "daemon off;" >> /etc/nginx/nginx.conf  
  
WORKDIR /usr/src/app  
  
COPY ["package.json", "npm-shrinkwrap.json*", "./"]  
  
RUN npm install --silent  
COPY . .  
RUN npm run-script build  
RUN cp -r dist/. /var/www/html/  
  
EXPOSE 80  
CMD nginx  

