# adct - Dockerfile  
# https://github.com/ArtiomL/adct  
# Artiom Lichtenstein  
# v1.0.6, 09/01/2018  
FROM debian:stable-slim  
  
LABEL maintainer="Artiom Lichtenstein" version="1.0.6"  
  
# Core dependencies  
RUN apt-get update && \  
apt-get install -y apache2 php7.0 && \  
apt-get autoclean -y && \  
apt-get autoremove -y && \  
apt-get clean -y && \  
rm -rf /var/lib/apt/lists/*  
  
# adct  
COPY / /var/www/adct/  
RUN cp /var/www/adct/index.php /var/www/adct/secure/index.php  
  
# apache2  
RUN cp /var/www/adct/etc/adct*.conf /etc/apache2/sites-available/  
RUN cat /var/www/adct/etc/apache2.conf | tee -a /etc/apache2/apache2.conf  
RUN htpasswd -cb /etc/apache2/.htpasswd user user  
RUN a2dissite 000-default.conf  
RUN a2enmod ssl headers  
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf  
RUN sed -i 's/Listen 443/Listen 8443/g' /etc/apache2/ports.conf  
RUN a2ensite adct.conf adct-ssl.conf  
  
# System account  
RUN useradd -r -u 1001 user  
RUN chown -RL user: /etc/ssl/private/ /var/log/apache2/ /var/run/apache2/  
  
# Expose ports  
EXPOSE 8080 8443  
# UID to use when running the image and for CMD  
USER 1001  
# Run  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

