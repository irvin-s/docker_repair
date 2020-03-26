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
#
# Note!
# rootwrap.conf controls sudo/rootwrap access and in a secure setup needs to
# be installed from a trusted source to a location writeable only by
# root.  In the interests of easy testing of git HEAD, that is not
# what we're doing here.
#
RUN apt-get -qy --no-install-recommends install \
 libxslt-dev libxml2-dev libffi-dev libssl-dev && \
 mkdir -p /etc/cinder /var/lib/cinder /var/lock/cinder && \
 chown user:user /var/lib/cinder /var/lock/cinder && \
 ln -s $ETC/cinder/rootwrap.conf /etc/cinder/rootwrap.conf && \
 ln -s $ETC/cinder/rootwrap.d /etc/cinder/rootwrap.d && \
 echo "user ALL = (root) NOPASSWD: $PREFIX/venv/bin/cinder-rootwrap /etc/cinder/rootwrap.conf *" > /etc/sudoers.d/rootwrap

# _wrap.sh sets up environment and copies templated configs from $ETC_IN -> $ETC
COPY _wrap.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/_wrap.sh"]
CMD ["/bin/bash"]

USER install
RUN \
 set -x && \
 cd $PREFIX && \
 git clone --depth 1 --single-branch --branch master https://github.com/openstack/cinder.git git-fetch && \
 cd git-fetch && \
 virtualenv --system-site-packages $PREFIX/venv && \
 $PREFIX/venv/bin/pip install --upgrade pip && \
 $PREFIX/venv/bin/pip install --compile . PyMySQL && \
 mkdir -p $ETC_IN/cinder && \
 cp -r etc/cinder/* $ETC_IN/cinder/ && \
 . $PREFIX/venv/bin/activate && cinder-api --help >/dev/null

COPY cinder.conf.in /home/install/etc/nova/

USER user
WORKDIR /
EXPOSE 8776
