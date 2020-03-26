FROM amelia/php:cli  
  
RUN apk add \--no-cache git \  
&& mkdir -p /srv/code \  
&& composer create-project laravel/laravel /srv/code "~5.5" \  
&& rm -rf /var/cache/composer/* \  
&& apk del git  
  
WORKDIR /srv/code  
  
CMD ["php", "artisan", "tinker"]  

