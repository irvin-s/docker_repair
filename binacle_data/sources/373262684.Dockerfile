FROM losinggeneration/debian

# Update apt-get
RUN apt-get -y update

# Install apache + MySQL + PHP54
RUN apt-get -y -f install apache2 php5 mysql-server libapache2-mod-php5 php5-mysql php5-curl curl libicu-dev
RUN apt-get -y -f install php5-intl

# Install phpunit
RUN aptitude install -y -f phpunit

# Configure apache
RUN /bin/echo -e '<VirtualHost *:80>\nDocumentRoot /app/parallelTests/web\n<Directory "/app/parallelTests/web">\nAllowOverride All\n</Directory>\n</VirtualHost>' | tee /etc/apache2/sites-available/default > /dev/null

RUN a2enmod rewrite
RUN service apache2 reload

# Install git
RUN apt-get install -y -f git

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer

# Copy start script
ADD ./install.sh /install.sh

EXPOSE 80

CMD ["/bin/bash", "/install.sh"]
