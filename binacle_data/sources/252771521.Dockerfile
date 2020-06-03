FROM akeinhell/docker-nginx-php7.1  
WORKDIR /var/www  
  
ADD composer.json /var/www  
ADD composer.lock /var/www  
ADD package.json /var/www  
ADD package-lock.json /var/www  
  
RUN composer install --no-scripts --no-autoloader  
  
RUN npm install --ignore-scripts  
  
COPY . ./  
  
RUN composer dump-autoload --optimize && \  
composer run-script post-install-cmd  
  
RUN npm run build  
  
COPY public/dist ./public/dist  
  

