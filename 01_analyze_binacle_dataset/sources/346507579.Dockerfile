FROM ubuntu:14.04.5
MAINTAINER kost - https://github.com/kost

ENV SUDO_USER root

ADD /scripts /scripts

RUN /scripts/prepare.sh && \
apt-get -qq update && \
apt-get install -yq  wget bash && \
(wget --quiet -O - https://raw.github.com/sans-dfir/sift-bootstrap/master/bootstrap.sh | bash -s -- -i -s -y) && \
/scripts/cleanup.sh

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/sh"]


