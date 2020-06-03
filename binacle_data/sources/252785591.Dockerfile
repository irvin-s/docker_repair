FROM comicrelief/php-slim:7.1  
  
# Required by Jose token lib  
RUN apt-get -qq update \  
&& apt-get -qq install -y libgmp-dev \  
&& docker-php-ext-install gmp  

