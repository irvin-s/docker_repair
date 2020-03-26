FROM nginx

COPY default.conf  /etc/nginx/conf.d/default.conf

RUN chown -R nginx:nginx /usr/share/nginx/html/

VOLUME /usr/share/nginx/html
