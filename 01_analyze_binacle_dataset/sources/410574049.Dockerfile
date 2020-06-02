FROM octohost/php5

WORKDIR /srv/www

ADD . /srv/www
ADD ./default /etc/nginx/sites-available/default

RUN mkdir /srv/www/public/logs/ && chmod 777 /srv/www/public/logs/
RUN chmod -R 777 /srv/www/app/storage/
RUN chmod 775 /srv/www/start.sh

EXPOSE 80

CMD /srv/www/start.sh