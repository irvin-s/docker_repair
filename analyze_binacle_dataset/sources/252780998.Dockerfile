FROM php:5.6-apache  
ENV TERM xterm  
RUN apt-get update && apt-get install -y \  
wget \  
git \  
unzip \  
nano  
# && rm -rf /var/lib/apt/lists/*  
RUN docker-php-ext-install mysqli  
ADD composer-install.sh /var/  
RUN chmod +x /var/composer-install.sh  
RUN /var/composer-install.sh  
RUN mv composer.phar /usr/local/bin/composer  
RUN composer require slim/slim "3.0"  
RUN a2enmod rewrite  
ADD 000-default.conf /etc/apache2/sites-available/  
ADD conn.php /var/www/html/  
ADD public /var/www/html/public/  
RUN mv /var/www/html/public/_htaccess /var/www/html/public/.htaccess

