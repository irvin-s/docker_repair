FROM octohost/php5-apache

ADD . /var/www

RUN chmod 777 /var/www/wp-content/uploads

EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
