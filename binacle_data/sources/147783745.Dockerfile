FROM newdeveloper/apache-php-composer

RUN rm -rf /var/www/html/*
WORKDIR /var/www/html/
RUN git clone https://github.com/versx/RealDeviceMap-RaidBillBoard /var/www/html/
RUN composer install
COPY config.php /var/www/html/
COPY geofences/* /var/www/html/geofences/
COPY 000-default.conf /etc/apache2/sites-available/
