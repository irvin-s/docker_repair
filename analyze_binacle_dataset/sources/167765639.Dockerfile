FROM ubuntu:vivid
MAINTAINER Angus Lees <gus@inodes.org>

RUN adduser --disabled-login --gecos 'Generic unprivileged user' user

RUN apt-get -qq update
RUN apt-get -qqy upgrade

RUN apt-get -qqy --no-install-recommends install python-dev python-pip git

# Fetch as much as we can from apt
RUN apt-get -qqy --no-install-recommends install python-dnspython python-eventlet python-greenlet python-netifaces python-pastedeploy python-simplejson python-xattr rsync python-keystonemiddleware

USER user
RUN \
 mkdir -p /tmp/git-fetch && \
 cd /tmp/git-fetch && \
 git init && \
 git fetch --depth 1 https://github.com/openstack/swift.git master && \
 git checkout FETCH_HEAD
WORKDIR /tmp/git-fetch
USER root
RUN pip install -r requirements.txt
USER user
RUN python setup.py build
USER root
RUN python setup.py install && cp -r etc /etc/swift && \
 /usr/local/bin/swift-proxy-server --help

ADD swift.conf /etc/swift/swift.conf.in
ADD object-server.conf /etc/swift/object-server.conf.in
ADD container-server.conf /etc/swift/container-server.conf.in
ADD account-server.conf /etc/swift/account-server.conf.in
ADD proxy-server.conf /etc/swift/proxy-server.conf.in

ADD _wrap.sh /usr/local/bin/swift-object-auditor.sh
ADD _wrap.sh /usr/local/bin/swift-object-expirer.sh
ADD _wrap.sh /usr/local/bin/swift-object-replicator.sh
ADD _wrap.sh /usr/local/bin/swift-object-server.sh
ADD _wrap.sh /usr/local/bin/swift-object-updater.sh
ADD _wrap.sh /usr/local/bin/swift-proxy-server.sh
ADD _wrap.sh /usr/local/bin/swift-account-auditor.sh
ADD _wrap.sh /usr/local/bin/swift-account-reaper.sh
ADD _wrap.sh /usr/local/bin/swift-account-replicator.sh
ADD _wrap.sh /usr/local/bin/swift-account-server.sh
ADD _wrap.sh /usr/local/bin/swift-container-auditor.sh
ADD _wrap.sh /usr/local/bin/swift-container-replicator.sh
ADD _wrap.sh /usr/local/bin/swift-container-server.sh
ADD _wrap.sh /usr/local/bin/swift-container-sync.sh
ADD _wrap.sh /usr/local/bin/swift-container-updater.sh
ADD _wrap.sh /usr/local/bin/swift-container-reconciler.sh
ADD _wrap.sh /usr/local/bin/swift-ring-builder.sh

WORKDIR /
VOLUME ["/srv/node"]
EXPOSE 80 6000 6001 6002
