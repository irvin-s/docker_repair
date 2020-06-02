FROM dockerfile/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN apt-get update

# Install garphite-api
RUN apt-get install -y build-essential python3 python3-dev libffi-dev libcairo2-dev python3-pip supervisor nginx-light
RUN pip3 install gunicorn git+https://github.com/nacyot/graphite-api.git@master

# Set graphite data directory
RUN mkdir -p /opt/graphite/storage
RUN ln -s  /opt/graphite/storage /srv/graphite

ADD ./config/nginx.conf /etc/nginx/nginx.conf
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000
CMD ["/usr/bin/supervisord", "-n"]
