FROM nginx:mainline-alpine

RUN apk --update add php-fpm && \
    echo "clear_env = no" >> /etc/php/php-fpm.conf

COPY www /www
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD php-fpm -d variables_order="EGPCS" && (tail -F /var/log/nginx/access.log &) && exec nginx -g "daemon off;"
