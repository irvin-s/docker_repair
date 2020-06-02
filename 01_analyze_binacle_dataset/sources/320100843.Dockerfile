FROM qmu1/apache-php7:latest

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

ADD phpmyadmin-STABLE.zip /tmp/phpmyadmin.zip

WORKDIR /tmp

RUN unzip -q phpmyadmin.zip \
    && rm phpmyadmin.zip \
    && mv phpmyadmin-STABLE phpmyadmin

ADD config.inc.php /tmp/phpmyadmin/config.inc.php

RUN chmod 644 phpmyadmin/config.inc.php \
    && mkdir -p /var/www \
    && mv phpmyadmin /var/www

ADD 000-default.conf /etc/apache2/conf.d/default.conf
ENV MYSQL_ROOT_PASSWORD root
