FROM nginx:1.11.3

MAINTAINER Tim Co <tim@pinn.ai>

RUN apt-get update && apt-get install -qqy --no-install-recommends \
    supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY local.conf etc/nginx/conf.d/
COPY remote.conf etc/nginx/conf.d/

COPY nginx.sh /
COPY supervisord.conf /etc/supervisor/conf.d/app.conf
RUN mkdir -p /var/log/supervisord

RUN rm /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i '15i\ \tclient_max_body_size 75M;' /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/acces.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# EXPOSE 80
CMD ["usr/sbin/nginx"]
