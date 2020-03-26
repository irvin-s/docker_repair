FROM nginx:1-alpine

COPY default.conf.template /etc/nginx/conf.d/
COPY startup.sh /usr/local/bin/

CMD ["startup.sh"]
