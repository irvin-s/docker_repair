FROM turretio/golapa-base

COPY nginx_default.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisord.conf

ADD tmp/static /golapa/static
ADD tmp/templates /golapa/templates
ADD tmp/bin /golapa/bin

EXPOSE 80

ENTRYPOINT supervisord -n -c /etc/supervisord.conf
