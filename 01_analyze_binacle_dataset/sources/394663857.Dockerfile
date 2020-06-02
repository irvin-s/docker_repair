FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

COPY daemons-config.ini /etc/supervisord.d/daemons-config.ini

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
