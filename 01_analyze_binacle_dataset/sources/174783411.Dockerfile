FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install wget tar unzip git mercurial unzip which

RUN mkdir -p /opt/app && mkdir -p /opt/logs && touch /opt/logs/std.log

ADD . /opt/
WORKDIR /opt

RUN rm -f Dockerfile build

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp bin.conf scribed.conf /etc/supervisord.d/ \
    && rm -f bin.conf scribed.conf

