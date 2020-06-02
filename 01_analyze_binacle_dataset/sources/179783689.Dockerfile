FROM fellah/php

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

ADD https://wordpress.org/wordpress-4.3.1.tar.gz /tmp

RUN tar -zxf /tmp/wordpress-4.3.1.tar.gz -C /var/www/html --strip-components 1 && \
	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php && \
	sed -i 's/localhost/wordpress/g' /var/www/html/wp-config.php && \
	sed -i 's/username_here/wordpress/g' /var/www/html/wp-config.php && \
	sed -i 's/password_here/wordpress/g' /var/www/html/wp-config.php && \
	sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php && \
	chown -R www-data:www-data /var/www/html
