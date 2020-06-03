FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y php-fpm php-apcu python-pip
RUN    sed -i "s/listen =.*/listen = 0.0.0.0:9000/g" /etc/php-fpm.d/www.conf \
	&& sed -i "s/listen.allowed_clients =.*/;listen.allowed_clients = /g" /etc/php-fpm.d/www.conf \
	&& sed -i "s/user =.*/user = phd/g" /etc/php-fpm.d/www.conf \
	&& sed -i "s/group =.*/group = phd/g" /etc/php-fpm.d/www.conf \
	&& sed -i "s/;opcache.validate_timestamps=.*/opcache.validate_timestamps = 0/g" /etc/php.d/opcache.ini
RUN pip install pygments

COPY phabricator.ini /etc/php.d/phabricator.ini
COPY run.sh /run.sh

EXPOSE 9000

CMD ["/run.sh"]
