#
FROM centos_nginx
MAINTAINER xiaocai <miss339742811@163.com>

RUN groupadd worker
RUN useradd -g worker worker

RUN yum -y install git

#install nginx
ADD ./configure_nginx.sh /data/install/configure_nginx.sh
ADD ./package/composer.phar /data/install/composer.phar

RUN chmod 755 /data/install/configure_nginx.sh
RUN /data/install/configure_nginx.sh
RUN rm -rf /data/install/

RUN echo "alias php=/usr/local/php-5.4.40/bin/php" >> ~/.bash_profile
RUN echo "alias composer=/data/install/composer.phar" >> ~/.bash_profile
RUN echo "alias phpunit-bootstrap='/usr/local/php-5.4.40/bin/php /data/www/vendor/phpunit/phpunit/phpunit --bootstrap /data/www/test/bootstrap.php'" >> ~/.bash_profile
RUN echo "export PATH=/usr/local/php-5.4.40/bin:$PATH" >> ~/.bash_profile
#RUN source ~/.bash_profile
RUN echo "/etc/init.d/nginx start" >> /etc/rc.local
RUN echo "/etc/init.d/php-fpm start" >> /etc/rc.local
RUN echo "source ~/.bash_profile" >> /etc/rc.local

#start.sh
ADD ./start.sh /data/start.sh
RUN chmod 755 /data/start.sh

USER worker

ENTRYPOINT ["/data/start.sh"]
EXPOSE 80
