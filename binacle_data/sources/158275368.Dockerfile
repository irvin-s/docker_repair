FROM zeus/django-base:latest
MAINTAINER Sergey Fursov <geyser85@gmail.com>

ADD . /root/src/
RUN pip install -r /root/src/build/pipreq.txt -U

ADD build/supervisor.conf /etc/supervisor/conf.d/
