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
 iproute dnsmasq-utils dnsmasq-base iputils-arping ipset && \
 mkdir -p /etc/neutron /var/lib/neutron /var/lock/neutron && \
 chown user:user /var/lib/neutron /var/lock/neutron && \
 ln -s $ETC/neutron/rootwrap.conf /etc/neutron/rootwrap.conf && \
 ln -s $ETC/neutron/rootwrap.d /etc/neutron/rootwrap.d && \
 echo "user ALL = (root) NOPASSWD: $PREFIX/venv/bin/neutron-rootwrap /etc/neutron/rootwrap.conf *" > /etc/sudoers.d/rootwrap

# _wrap.sh sets up environment and copies templated configs from $ETC_IN -> $ETC
COPY _wrap.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/_wrap.sh"]
CMD ["/bin/bash"]

# Note neutron git repo has files in both etc/ and etc/neutron
USER install
RUN \
 set -x && \
 cd $PREFIX && \
 git clone --depth 1 --single-branch --branch master https://github.com/openstack/neutron.git git-fetch && \
 cd git-fetch && \
 virtualenv --system-site-packages $PREFIX/venv && \
 $PREFIX/venv/bin/pip install --upgrade pip && \
 $PREFIX/venv/bin/pip install --compile . PyMySQL && \
 mkdir -p $ETC_IN/neutron && \
 cp -r etc/* $ETC_IN/neutron/ && \
 mv $ETC_IN/neutron/neutron/* $ETC_IN/neutron/ && \
 rmdir $ETC_IN/neutron/neutron && \
 . $PREFIX/venv/bin/activate && neutron-server --help >/dev/null

COPY neutron.conf.in l3_agent_network.ini.in l3_agent_compute.ini.in metadata_agent.ini.in ml2_conf.ini.in /etc/neutron/

USER user
WORKDIR /
EXPOSE 9696 9697 4789
