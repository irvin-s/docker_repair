FROM davask/d-php-letsencrypt:7.0-a2.4-d8.8  
MAINTAINER davask <docker@davaskweblimited.com>  
USER root  
LABEL dwl.app.cms="WordPress 4.4.2"  
# Copy instantiation specific file  
COPY ./build/dwl/get-wordpress.sh \  
./build/dwl/fix-wordpress-permissions.sh \  
./build/dwl/init.sh \  
/dwl/  
  
# CMD ["/dwl/init.sh && service sendmail start && apache2ctl -D FOREGROUND"]  
RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl  
USER admin  

