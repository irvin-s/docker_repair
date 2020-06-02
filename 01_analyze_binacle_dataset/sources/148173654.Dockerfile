FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y nginx supervisor
RUN pip3 install uwsgi Flask

ADD ./app /app
ADD ./config /config

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

RUN ln -s /config/nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /config/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 80

CMD ["supervisord", "-n"]
