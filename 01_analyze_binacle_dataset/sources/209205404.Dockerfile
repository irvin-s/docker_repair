FROM diegomarangoni/hhvm

ADD config/php.ini /etc/hhvm
ADD config/server.ini /etc/hhvm

EXPOSE 9000

RUN usermod -u 1000 www-data
WORKDIR /var/www/app

CMD ["hhvm", "--mode=server"]
