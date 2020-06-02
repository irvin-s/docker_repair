FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum install -y wget tar gcc zlib zlib-devel openssl openssl-devel unzip mysql-devel python-devel

RUN mkdir /opt/logs
RUN mkdir /usr/src/python
WORKDIR /usr/src/python

ENV LANG en_US.UTF-8
ENV PYTHON_VERSION 2.7.6

RUN curl -SL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz" | tar xvzf - --strip-components=1
RUN ./configure \
    && make \
    && make install \
    && make clean

RUN sed 's/\/usr\/bin\/python/\/usr\/bin\/python2.6/g' /usr/bin/yum > /usr/bin/yum.tmp \
    && mv /usr/bin/yum.tmp /usr/bin/yum \
    && chmod 755  /usr/bin/yum

ADD . /opt/
WORKDIR /opt

RUN tar zxvf scribed.tar.gz \
    && chown -R root:root scribed \
    && rm -f scribed.tar.gz

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install -r requirements.txt \
    && rm -f requirements.txt

RUN easy_install virtualenv \
    && easy_install mysql-connector-python \
    && easy_install MySQL-python

RUN easy_install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp gunicorn.conf scribed.conf /etc/supervisord.d/ \
    && rm -f gunicorn.conf scribed.conf Dockerfile
