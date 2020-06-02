FROM nginx:1.13
CMD /bin/bash -c " \
    envsubst '\$ROCDEV_APP_HOST' \
      < /etc/nginx/conf.d/default.conf \
      > /etc/nginx/conf.d/default.conf \
    && \
    nginx -g 'daemon off;' \
    "
RUN rm /usr/share/nginx/html/index.html
COPY rocdev.vh.conf /etc/nginx/conf.d/default.conf
