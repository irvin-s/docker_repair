# Creates openstack glance image
#
# Author: Paul Czarkowski

FROM dockenstack/base

ENV VERSION=stable/kilo

RUN \
  git clone --depth 1 -b $VERSION https://github.com/openstack/glance.git /app/glance && \
  cd /app/glance && \
  pip install -r /app/glance/requirements.txt && \
  python setup.py install && \
  mkdir -p /etc/glance && \
  mkdir -p /var/lib/glance/images && \
  mkdir -p /var/log/glance && \
  pip install python-glanceclient

EXPOSE 9191 9292

VOLUME ["/var/lib/glance", "/var/log/glance"]

CMD ["/app/bin/boot"]

ADD . /app

RUN chmod +x /app/bin/*
