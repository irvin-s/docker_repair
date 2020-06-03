FROM jwilder/nginx-proxy:latest
MAINTAINER Juan Luis Baptiste <juan.baptiste@gmail.com>

RUN { \
      echo 'client_max_body_size 10m;'; \
    } > /etc/nginx/conf.d/my_proxy.conf