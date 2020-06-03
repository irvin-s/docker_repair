FROM nginx
COPY nginx.conf.template.simple /etc/nginx/nginx.conf.template
RUN mkdir -p /var/www/cache
CMD envsubst '$$AUTO_DEPLOY' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx
