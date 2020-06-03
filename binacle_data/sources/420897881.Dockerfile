FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y software-properties-common python2.7 \
  python-setuptools python-dev libevent-dev \
  supervisor python-pandas ruby nginx
RUN apt-add-repository -y ppa:chris-lea/node.js
RUN apt-get update && apt-get install -y nodejs
RUN gem install sass
RUN easy_install pip
RUN pip install uwsgi==2.0.9
RUN npm install -g grunt-cli
COPY chronology/jia/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
COPY chronology /chronology
WORKDIR /chronology/jia
RUN npm install
RUN grunt build
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["/usr/bin/supervisord"]
