FROM    debian:stable
ENV     DEBIAN_FRONTEND noninteractive
ENV     TERM xterm
MAINTAINER Round Cube <rc@xxx.org>

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends \
    nginx php5-fpm nano wget sqlite3 procps \
    php5-mcrypt php5-intl php5-sqlite php-pear \
    php-net-smtp php-mail-mime
WORKDIR /root
# when roundcube grows older, change version in the download link, but also in the 'mv' command
RUN \
    wget http://downloads.sourceforge.net/project/roundcubemail/roundcubemail/1.1.2/roundcubemail-1.1.2.tar.gz -O - | tar xz ;\
    rm -fr /usr/share/nginx/www ;\
    mv /root/roundcubemail-1.1.2 /usr/share/nginx/www ;\
    rm -fr /usr/share/nginx/www/installer ;\
    mkdir -p /rc
ADD config.inc.php /usr/share/nginx/www/config/
ADD default /etc/nginx/sites-enabled/default
ADD launch.sh /root/

VOLUME /rc
CMD [ "bash", "/root/launch.sh" ]
