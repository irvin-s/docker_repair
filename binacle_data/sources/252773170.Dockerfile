FROM php:7.2-alpine3.7  
RUN apk add -U --no-cache git zlib-dev libpng-dev icu-dev \  
&& docker-php-ext-install -j$(nproc) zip mysqli gd intl \  
&& git clone -b MOODLE_34_STABLE --depth=1 git://git.moodle.org/moodle.git \  
&& mkdir /moodle/data  
ADD config.php /moodle/config.php  
WORKDIR /moodle  
  
EXPOSE 80  
ENTRYPOINT ["php"]  
CMD ["-S", "0.0.0.0:80"]  

