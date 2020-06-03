FROM billwilliam/apache-php  
  
MAINTAINER Billaud <william.billaud@isen.yncrea.fr>  
  
# Install other needed extensions  
RUN apt-get update \  
&& apt-get install -y libpq-dev libpcre3-dev\  
&& docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \  
&& docker-php-ext-install pdo pdo_pgsql pgsql  

