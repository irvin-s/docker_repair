FROM richarvey/nginx-php-fpm  
  
LABEL maintainer="arcolan <sylvain@arcolan.fr>"  
RUN cd /root \  
&& wget -qO- -O tmp.zip https://getgrav.org/download/core/grav-admin/latest \  
&& unzip tmp.zip \  
&& rm tmp.zip \  
&& cd /var/www \  
&& rm -Rf html \  
&& mv /root/grav-admin html \  
&& cd html \  
&& bin/gpm selfupgrade -fy \  
&& bin/gpm update -fy \  
&& bin/grav clear-cache \  
&& chown -R nginx:nginx /var/www/html \  
&& cp -r /var/www/html/user /tmp/ \  
&& mkdir /var/www/html/scripts  
  
COPY default.conf /etc/nginx/sites-available/  
COPY init.sh /var/www/html/scripts/  
  
VOLUME /var/www/html/user  
EXPOSE 80  
  
CMD ["/start.sh"]  

