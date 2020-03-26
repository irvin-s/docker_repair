FROM node:0.12  
MAINTAINER Alberto Conteras <abecontreras@me.com>  
  
RUN npm install -g node-sass postcss-cli autoprefixer watch  
  
WORKDIR /var/www  
  
RUN usermod -u 1000 www-data  
RUN usermod -a -G users www-data  
  
RUN chown -R www-data:www-data /var/www  
  
CMD [ "watch", "npm" ]  

