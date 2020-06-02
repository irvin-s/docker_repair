FROM octohost/php5:5.5

RUN apt-get update && apt-get install -y php-getid3

ADD . /srv/www
WORKDIR /srv/www

EXPOSE 80

# Remember how you're not supposed to start services in docker containers? too late.
CMD service php5-fpm start && nginx
