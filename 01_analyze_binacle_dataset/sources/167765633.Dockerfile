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
 libxslt-dev libxml2-dev zlib1g-dev libyaml-dev libffi-dev libssl-dev \
 iproute2 iptables novnc python-libvirt && \
 mkdir -p /etc/nova /var/lib/nova /var/lock/nova && \
 chown user:user /var/lib/nova /var/lock/nova && \
 ln -s $ETC/nova/rootwrap.conf /etc/nova/rootwrap.conf && \
 ln -s $ETC/nova/rootwrap.d /etc/nova/rootwrap.d && \
 echo "user ALL = (root) NOPASSWD: $PREFIX/venv/bin/nova-rootwrap /etc/nova/rootwrap.conf *" > /etc/sudoers.d/rootwrap

# _wrap.sh sets up environment and copies templated configs from $ETC_IN -> $ETC
COPY _wrap.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/_wrap.sh"]
CMD ["/bin/bash"]

USER install
RUN \
 set -x && \
 cd $PREFIX && \
 git clone --depth 1 --single-branch --branch master https://github.com/openstack/nova.git git-fetch && \
 cd git-fetch && \
 virtualenv --system-site-packages $PREFIX/venv && \
 $PREFIX/venv/bin/pip install --upgrade --compile pip && \
 $PREFIX/venv/bin/pip install --compile 'pbr>=1.3' && \
 $PREFIX/venv/bin/pip install --compile . PyMySQL && \
 mkdir -p $ETC_IN && \
 cp -r etc/nova $ETC_IN/nova && \
 . $PREFIX/venv/bin/activate && nova-api --help >/dev/null

COPY nova.conf.in /home/install/etc/nova/

USER user
WORKDIR /
VOLUME ["/instances"]
EXPOSE 8773 8774 8775 6080
