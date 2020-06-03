FROM php:7-apache  
  
ADD lazarusgb-1.24.zip /tmp/  
ADD lazarusgb-1.25b1.zip /tmp/  
  
RUN apt-get update \  
&& apt-get -y install \  
unzip \  
libfreetype6-dev \  
libjpeg62-turbo-dev \  
libpng12-dev \  
&& rm -rf /var/lib/apt /var/cache/apt  
  
RUN docker-php-ext-configure mysqli \  
&& docker-php-ext-install mysqli \  
&& docker-php-ext-enable mysqli \  
&& docker-php-ext-configure gd \  
&& docker-php-ext-install gd \  
&& docker-php-ext-enable gd \  
&& docker-php-source delete  
  
RUN cd /var/www/html/ \  
&& unzip /tmp/lazarusgb-1.24.zip \  
&& mv lazarusgb/* ./ \  
&& mv lazarusgb/.htaccess ./ \  
&& unzip -o /tmp/lazarusgb-1.25b1.zip \  
&& chmod 777 tmp/ public/ \  
&& rm -rf /tmp/*.zip  

