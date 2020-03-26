FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y software-properties-common python2.7 \
  python-setuptools python-dev libevent-dev \
  supervisor python-pandas nginx
RUN easy_install pip
RUN pip install uwsgi==2.0.9
COPY chronology/metis/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
COPY chronology /chronology
WORKDIR /chronology/metis
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["/usr/bin/supervisord"]
