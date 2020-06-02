# This Dockerfile based on dockerana/dockerana
FROM nacyot/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN apt-get -y update
RUN apt-get -y install git python-django python-django-tagging python-simplejson \
                           python-memcache python-ldap python-cairo \
                           python-twisted python-pysqlite2 python-support \
                           python-pip

WORKDIR /usr/local/src

RUN git clone https://github.com/graphite-project/carbon.git
RUN git clone https://github.com/graphite-project/whisper.git
RUN cd whisper && git checkout master && python setup.py install
RUN cd carbon && git checkout 0.9.x && python setup.py install

ADD ./config /opt/graphite/conf/
EXPOSE 2003 2004 7002
CMD ["/opt/graphite/bin/carbon-cache.py", "--debug", "start"]
