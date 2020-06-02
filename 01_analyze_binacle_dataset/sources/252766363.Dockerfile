FROM debian:stretch-slim  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
autoconf \  
automake \  
libtool \  
re2c \  
bison \  
libxml2-dev \  
zlib1g-dev  
  
VOLUME /src/php-src  
  
WORKDIR /src/php-src  
  
COPY php-src-devtools-entrypoint /usr/local/bin  
  
ENTRYPOINT ["php-src-devtools-entrypoint"]  

