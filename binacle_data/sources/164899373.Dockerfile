FROM ubuntu:latest

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2

ADD . /mnt
RUN ( cd /mnt; dpkg -i *.deb )

RUN sed -i \
 's/<\/VirtualHost>/\n\tJkMount \/* loadbalancer\n<\/VirtualHost>/g' \
 /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

CMD [ "/bin/bash", "-c", "source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND"  ]

