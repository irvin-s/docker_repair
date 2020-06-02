# start with a base image
FROM ubuntu:14.10
MAINTAINER Real Python <info@realpython.com>

# install dependencies
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y supervisor
RUN apt-get install -y python3-pip
RUN pip3 install uwsgi flask

# update working directories
ADD ./app /app
ADD ./config /config

# setup config
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

RUN ln -s /config/nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /config/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["supervisord", "-n"]