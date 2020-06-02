FROM ubuntu:16.04

MAINTAINER Dmitry Mukovkin mukovkin@yandex.ru

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    nginx \
    supervisor \
    mysql-client \
    libmysqlclient-dev \
    curl

RUN rm -rf /var/lib/apt/lists/*

# nginx config
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/sites-available/default

# supervisor config
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# uWSGI config
COPY uwsgi.ini /app/uwsgi.ini
COPY uwsgi_params /app/uwsgi_params

# Copy initialization scripts
COPY start.sh /app/start.sh

VOLUME ["/app/platform"]
EXPOSE 80

CMD ["/bin/bash", "/app/start.sh"]