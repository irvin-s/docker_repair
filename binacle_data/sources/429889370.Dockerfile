# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/11/2013

FROM dockenstack/base

ENV VERSION=stable/kilo

RUN \
  git clone --depth 1 -b $VERSION https://github.com/openstack/keystone.git /app/keystone && \
  cd /app/keystone && \
  pip install -r /app/keystone/requirements.txt && \
  python setup.py install && \
  mkdir -p /etc/keystone && \
  chmod 0700 /etc/keystone

EXPOSE 5000 35357

ADD . /app

RUN chmod +x /app/bin/*

CMD ["/app/bin/boot"]
