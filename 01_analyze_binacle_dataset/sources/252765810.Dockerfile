FROM maat8/php7-composer  
MAINTAINER Florian Baltes <3baltes@informatik.uni-hamburg.de>  
  
WORKDIR /opt/drvt-backend  
  
ADD . /opt/drvt-backend  
  
#Self-Update Composer  
RUN composer self-update  
  
#Clean the directory  
RUN rm -rf tests \  
&& rm -rf var/cache/* \  
&& rm -rf var/logs/* \  
&& rm -rf vendor \  
&& rm Dockerfile \  
&& rm phpunit.xml.dist \  
&& rm README.md  
  
# Install Composer Dependencies  
RUN composer install  
  
# Generate empty Database  
RUN rm app/data.db3  
RUN php bin/console doctrine:schema:create  
  
EXPOSE 80  
CMD php bin/console server:run 0.0.0.0:80  
  

