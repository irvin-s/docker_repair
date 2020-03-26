FROM ubuntu:14.04
MAINTAINER william.glass@gmail.com

RUN apt-get update \
    && apt-get install -y git \
       haproxy \
       python-pip python-virtualenv python-dev python-setuptools

RUN pip install supervisor
COPY supervisord/supervisord.conf /etc/supervisord/supervisord.conf

COPY lighthouse-*.tar.gz /opt/src/lighthouse.tar.gz
RUN cd /opt/src; tar -zxvf lighthouse.tar.gz

RUN virtualenv -p /usr/bin/python2.7 /opt/venvs/lighthouse
RUN . /opt/venvs/lighthouse/bin/activate; cd /opt/src/lighthouse-*; pip install -e .[redis]

RUN mkdir -p /var/log/supervisor/lighthouse
COPY supervisord/lighthouse.conf /etc/supervisord/conf.d/

RUN mkdir -p /etc/lighthouse/balancers
RUN mkdir -p /etc/lighthouse/clusters
RUN mkdir -p /etc/lighthouse/discovery
RUN mkdir -p /etc/lighthouse/services

# haproxy peer port
EXPOSE 1024
# haproxy web port
EXPOSE 9009
# supervisor web port
EXPOSE 9000

CMD supervisord -c /etc/supervisord/supervisord.conf
