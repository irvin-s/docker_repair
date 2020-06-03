FROM ubuntu:bionic
MAINTAINER Tobias Bräutigam <braeutigam@gonicus.de>
RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
 apt-get -y install \
 build-essential \
 git \
 libsasl2-dev \
 python3 \
 python3-babel \
 python3-bcrypt \
 python3-colorlog \
 python3-crypto \
 python3-cryptography \
 python3-cups \
 python3-decorator \
 python3-dev \
 python3-dnspython \
 python3-lazy-object-proxy \
 python3-ldap \
 python3-lxml \
 python3-netaddr \
 python3-netifaces \
 python3-openssl \
 python3-paho-mqtt \
 python3-passlib \
 python3-polib \
 python3-psycopg2 \
 python3-pyasn1 \
 python3-pycountry \
 python3-pycparser \
 python3-pycurl \
 python3-pyldap \
 python3-pytest-pylint \
 python3-pytest-runner \
 python3-pyotp \
 python3-pyqrcode \
 python3-requests \
 python3-setproctitle \
 python3-setuptools \
 python3-sh \
 python3-sqlalchemy \
 python3-sqlalchemy-ext \
 python3-sqlalchemy-utils \
 python3-tornado \
 python3-u2flib-server \
 python3-urllib3 \
 python3-unidecode \
 python3-willow \
 python3-xdg \
 python3-zope.event \
 python3-zope.interface \
 python3-pip \
 libldap2-dev \
 libusb-1.0-0-dev \
 libudev-dev \
 python-setuptools \
 nodejs

 # python-setuptools used by setup.py of syncrepl-client

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    google-chrome-stable


RUN mkdir -p /var/log/gosa
RUN mkdir -p /var/lib/gosa
RUN mkdir -p /etc/gosa
RUN mkdir -p /var/lib/gosa/workflows

RUN apt-get install locales
RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.UTF-8

COPY test_conf/config /etc/gosa/
COPY test_conf/org.gosa.conf /etc/dbus-1/system.d/

ENV TZ=Europe/Berlin
ENV TRAVIS=true
ENV SKIP_GUI_TESTS=true
WORKDIR /opt/gosa
CMD service dbus start && ./setup.py develop && $COMMAND