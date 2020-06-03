FROM ubuntu:14.04  
MAINTAINER Daniel Johansson <donnex@donnex.net>  
  
RUN apt-get update \  
&& apt-get install -y php5-fpm php5-mysql php5-gd \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf  
  
EXPOSE 9000  
CMD ["php5-fpm"]  

