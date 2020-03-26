FROM progrium/busybox

RUN opkg-install nginx
ADD nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/nginx /var/lib/nginx
ADD start.sh /start.sh
ADD assets /opt/symfony/web

EXPOSE 80

ENTRYPOINT ["/start.sh"]
