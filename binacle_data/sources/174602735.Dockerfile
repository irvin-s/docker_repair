FROM marvambass/nginx-ssl-php
MAINTAINER MarvAmBass

ENV DH_SIZE 1024

RUN apt-get -q -y update && \
    apt-get -q -y install mysql-client \
                          php5-mysql \
                          php5-gd \
                          php5-mcrypt \
                          wget \
                          unzip && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN php5enmod mcrypt; \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' \
           /etc/php5/fpm/php.ini; \
    \
    echo "clean http directory"; \
    rm -rf /usr/share/nginx/html/*; \
    \
    wget "https://files.phpmyadmin.net/phpMyAdmin/4.6.6/phpMyAdmin-4.6.6-all-languages.zip" -O phpMyAdmin.zip && \
    unzip phpMyAdmin.zip && \
    rm phpMyAdmin.zip; \
    mv phpMyAdmin-*-languages /phpmyadmin; \
    \
    echo "delete phpmyadmin config folder"; \
    rm -rf /phpmyadmin/config;

# install nginx phpmyadmin config
ADD nginx-phpmyadmin.conf /etc/nginx/conf.d/nginx-phpmyadmin.conf

# install personal phpmyadmin config
ADD config.inc.php /phpmyadmin/config.inc.php

# add startup.sh
ADD startup-phpmyadmin.sh /opt/startup-phpmyadmin.sh

COPY docker-healthcheck /usr/local/bin/
HEALTHCHECK CMD ["docker-healthcheck"]

# add '/opt/startup-phpmyadmin.sh' to entrypoint.sh
RUN sed -i 's/#!\/bin\/bash/#!\/bin\/bash\n\/opt\/startup-phpmyadmin.sh/g' /opt/entrypoint.sh
