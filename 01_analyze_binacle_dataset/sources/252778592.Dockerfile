FROM dylanlindgren/docker-laravel-nginx:latest  
  
# Add to working dir  
WORKDIR /data/www  
ADD . /data/www

