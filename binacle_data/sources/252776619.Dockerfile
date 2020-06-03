FROM node:6.13.0-slim  
  
MAINTAINER Alberto Conteras <a.contreras@catchdigital.com>  
  
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g node-sass postcss-cli autoprefixer watch  
  
WORKDIR /var/www  
  
RUN usermod -a -G users www-data  
  
RUN chown -R www-data:www-data /var/www  
  
CMD [ "watch", "npm" ]  

