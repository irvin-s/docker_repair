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
 libyaml-dev libffi-dev libssl-dev && \
 mkdir -p /var/lib/glance /var/lock/glance && \
 chown user:user /var/lib/glance /var/lock/glance

# _wrap.sh sets up environment and copies templated configs from $ETC_IN -> $ETC
COPY _wrap.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/_wrap.sh"]
CMD ["/bin/bash"]

USER install
RUN \
 set -x && \
 cd $PREFIX && \
 git clone --depth 1 --single-branch --branch master https://github.com/openstack/glance.git git-fetch && \
 cd git-fetch && \
 virtualenv --system-site-packages $PREFIX/venv && \
 $PREFIX/venv/bin/pip install --upgrade pip && \
 $PREFIX/venv/bin/pip install --compile . PyMySQL && \
 mkdir -p $ETC_IN && \
 cp -r etc $ETC_IN/glance && \
 . $PREFIX/venv/bin/activate && glance-api --help >/dev/null

COPY glance-api.conf.in glance-registry.conf.in glance-scrubber.conf.in glance-cache.conf.in glance-manage.conf.in /home/install/etc/glance/

USER user
WORKDIR /
VOLUME ["/store", "/cache", "/lock"]
EXPOSE 9292 9191
