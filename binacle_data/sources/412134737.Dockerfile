# Cluster image

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

RUN apk add --update supervisor nginx && rm -rf /var/cache/apk/* && mkdir -p /var/www/html

COPY files/index.html files/swarm.png /var/www/html/
COPY files/start.sh /script/
COPY files/default.conf /etc/nginx/conf.d/
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/supervisord.conf /etc/supervisord.conf

RUN chown -R nginx:nginx /var/www/html

EXPOSE 80/tcp

ENTRYPOINT ["supervisord"]
CMD ["-c","/etc/supervisord.conf"]