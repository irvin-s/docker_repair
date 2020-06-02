FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y npm
RUN touch /var/log/aphlict.log && chown phd:phd /var/log/aphlict.log

COPY aphlict-supervisor.ini /etc/supervisor/conf.d/aphlict-supervisor.ini

EXPOSE 22280 22281

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
