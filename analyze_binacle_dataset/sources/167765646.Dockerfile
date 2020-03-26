FROM ubuntu:utopic
MAINTAINER Angus Lees <gus@inodes.org>

ENV \
 PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin \
 PREFIX=/home/install \
 ETC_IN=/home/install/etc \
 ETC=/home/user/etc

# Run pip install as one (non-root) user, and run resulting binaries
# as another.
RUN \
 apt-get -q update && apt-get -qy upgrade && \
 adduser --disabled-login --gecos 'Unprivileged runtime user' user && \
 adduser --disabled-login --gecos 'Unprivileged install user' install && \
 apt-get -qy --no-install-recommends install \
 sudo virtualenv python-dev python-pip git build-essential

# System depdendencies needed to build python modules, followed by runtime deps.
RUN apt-get -qy --no-install-recommends install \
 libxslt-dev libxml2-dev zlib1g-dev libyaml-dev libffi-dev libssl-dev

# _wrap.sh sets up environment and copies templated configs from $ETC_IN -> $ETC
COPY _wrap.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/_wrap.sh"]
CMD ["/bin/bash"]

USER install
RUN \
 set -x && \
 cd $PREFIX && \
 git clone --depth 1 --single-branch --branch master https://github.com/openstack/tempest.git git-fetch && \
 cd git-fetch && \
 virtualenv --system-site-packages $PREFIX/venv && \
 $PREFIX/venv/bin/pip install --upgrade pip && \
 $PREFIX/venv/bin/pip install --compile . && \
 mkdir -p $ETC_IN/tempest && \
 cp -r etc/* $ETC_IN/tempest/ && \
 . $PREFIX/venv/bin/activate && run-tempest-stress --help >/dev/null

COPY tempest.conf.in /home/install/etc/tempest/

COPY tempest_user.sh /usr/local/bin/tempest_user.sh
COPY openrc /home/user/openrc

USER user
WORKDIR /
ENTRYPOINT ["/usr/local/bin/tempest_user.sh"]
