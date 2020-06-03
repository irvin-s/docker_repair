FROM debian:7.6  
MAINTAINER damien.duportal@gmail.com  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV LC_ALL C.UTF-8  
RUN echo 'LC_ALL=C.UTF-8' >> /etc/environment \  
&& echo 'DEBIAN_FRONTEND=noninteractive' >> /etc/environment \  
&& apt-get update && apt-get install -y -q --no-install-recommends \  
php5-fpm php5-mysql php5-gd php5-dev php5-curl \  
php-apc php5-cli php5-json php5-ldap php5-pgsql \  
&& apt-get autoremove -y -q \  
&& apt-get clean -y -q  
  
COPY php-fpm.conf /etc/php5/fpm/  
COPY www.conf /etc/php5/fpm/pool.d/www.conf  
  
EXPOSE 9000  
CMD ["php5-fpm","-R"]  

