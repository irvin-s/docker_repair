# install packages
FROM ubuntu
RUN apt-get update
RUN apt-get install -y supervisor
RUN apt-get install -y nginx

RUN mkdir -p /var/log/nginx/healthd; chown www-data.adm /var/log/nginx/healthd

# set up supervisord
ADD docker-assets/nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# set up nginx
ADD docker-assets/nginx/nginx.conf /etc/nginx/conf.d/container.conf

ADD client /var/app/current/client

# expose nginx port
EXPOSE 8080

WORKDIR "/var/app/current"

CMD ["/usr/bin/supervisord"]
