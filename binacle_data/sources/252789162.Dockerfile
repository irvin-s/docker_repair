FROM wordpress  
  
# zlib is needed by php-ext zip  
RUN apt-get update && \  
apt-get install -y \  
zlib1g-dev  
  
# mbstring is needed by some plugins  
RUN docker-php-ext-install mbstring zip  
  

