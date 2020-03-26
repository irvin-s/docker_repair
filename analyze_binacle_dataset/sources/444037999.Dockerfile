FROM xeor/base-centos-daemon

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-01-13

RUN yum install -y postgresql postgresql-devel gcc libxslt-devel python-debug && \
    pip install python-decouple sentry[postgres]

COPY supervisord.d/ /etc/supervisord.d/
COPY init/ /init/

COPY autoauth.py /usr/lib/python2.7/site-packages/sentry/utils/autoauth.py
COPY sentry.conf.py /

VOLUME ["/data"]
EXPOSE 8080
