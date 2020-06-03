# PHP Symfony2 dockerfile with PHP 5.5

FROM gezpage/ubuntu

MAINTAINER gezpage@gmail.com

ADD files/install.sh /root/install.sh
RUN /root/install.sh

ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD files/cliphp.ini /etc/php5/cli/php.ini
ADD files/apachephp.ini /etc/php5/apache2/php.ini
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD files/.bashrc /home/www-user/.bashrc

RUN chown www-user.www-data /home/www-user/.bashrc

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
