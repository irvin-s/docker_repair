FROM __BASEIMAGE_ARCH__/python:alpine

ENV QEMU_EXECVE 1
COPY ./tmp/qemu/qemu-__QEMU_ARCH__-static /usr/bin/
COPY ./tmp/dsmr/ /dsmr

ENV DSMR_USER admin
ENV DSMR_EMAIL root@localhost
ENV DSMR_PASSWORD admin

ENV DB_HOST dsmrdb
ENV DB_USER dsmrreader
ENV DB_PASS dsmrreader
ENV DB_NAME dsmrreader

ENV AUTORESTART_DATALOGGER true

RUN ["/usr/bin/qemu-__QEMU_ARCH__-static", "/bin/sh", "-c", \
     "apk --update add --no-cache \
      bash \
      curl \
      nginx \
      postgresql-client \
      supervisor"]

RUN ["/usr/bin/qemu-__QEMU_ARCH__-static", "/bin/sh", "-c", \
     "cp /dsmr/dsmrreader/provisioning/django/postgresql.py /dsmr/dsmrreader/settings.py"]

RUN ["/usr/bin/qemu-__QEMU_ARCH__-static", "/bin/sh", "-c", \
     "apk add --virtual .build-deps gcc musl-dev postgresql-dev && \
      pip3 install -r /dsmr/dsmrreader/provisioning/requirements/base.txt --no-cache-dir && \
      pip3 install -r /dsmr/dsmrreader/provisioning/requirements/postgresql.txt --no-cache-dir && \
      apk --purge del .build-deps && \
      rm -rf /tmp/*"]

RUN ["/usr/bin/qemu-__QEMU_ARCH__-static", "/bin/sh", "-c", \
     "mkdir -p /run/nginx/ && \
      ln -sf /dev/stdout /var/log/nginx/access.log && \
      ln -sf /dev/stderr /var/log/nginx/error.log && \
      rm -f /etc/nginx/conf.d/default.conf && \
      mkdir -p /var/www/dsmrreader/static && \
      cp /dsmr/dsmrreader/provisioning/nginx/dsmr-webinterface /etc/nginx/conf.d/dsmr-webinterface.conf"]

COPY ./app/run.sh /run.sh
RUN ["/usr/bin/qemu-__QEMU_ARCH__-static", "/bin/sh", "-c", \
     "chmod u+x /run.sh"]

COPY ./app/supervisord.ini /etc/supervisor.d/supervisord.ini

EXPOSE 80 443

WORKDIR /dsmr

CMD ["/run.sh"]
