FROM octohost/php5  
  
RUN apt-get update  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get install -y git-core  
  
ADD nginx.conf /etc/nginx/sites-available/default  
  
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini  
  
ENV COMPOSER_HOME /root/.composer  
ENV PATH /root/.composer/vendor/bin:$PATH  
ADD config.json /root/.composer/config.json  
  
ONBUILD ADD . /srv/www/  
ONBUILD WORKDIR /srv/www/  
ONBUILD RUN composer install  
  
EXPOSE 80  
  
CMD service php5-fpm start && nginx  

