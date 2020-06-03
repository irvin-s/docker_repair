FROM dotronglong/php-alpine  
  
RUN apk add git \  
&& docker-php-source extract \  
&& cd /usr/src/php \  
&& ./buildconf --force \  
&& ./configure --enable-phpdbg \  
&& make -j8 \  
&& make install-phpdbg \  
&& make clean \  
&& docker-php-source delete  
  
ENTRYPOINT ["phpdbg"]  

