FROM fcoelho/phpfpm

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y curl bzip2 supervisor cron

RUN echo '*/15 * * * * www-data php -f /owncloud/cron.php' >> /etc/crontab
RUN cd /root && curl https://download.owncloud.org/community/owncloud-7.0.4.tar.bz2 | tar xj

ADD owncloud-supervisor.conf /etc/supervisor/conf.d/owncloud-supervisor.conf
ADD owncloud-run.sh /owncloud-run.sh

VOLUME ["/owncloud", "/data"]

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
