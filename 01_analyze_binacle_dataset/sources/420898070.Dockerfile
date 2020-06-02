# https://docs.docker.com/articles/dockerfile_best-practices/
# Check for updates:
#   https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
FROM phusion/baseimage:0.9.16

# Install dependencies.
RUN \
  apt-get update && \
  apt-get install -y \
  build-essential \
  libevent-dev \
  libpcre3-dev \
  python-all-dev \
  python-pip \
  python2.7 \
  uuid-dev \
  wget

COPY chronology/kronos/requirements.txt /requirements.txt
RUN sudo pip install -r /requirements.txt

COPY chronology /chronology
WORKDIR /chronology/kronos

RUN python setup.py install
RUN mkdir -p /home/kronos && chown -R kronos:kronos /home/kronos

RUN mkdir /etc/service/kronos
COPY kronos.sh /etc/service/kronos/run
CMD ["/sbin/my_init"]
