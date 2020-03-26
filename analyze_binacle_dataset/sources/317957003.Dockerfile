FROM 192.168.24.1:8787/tripleoqueens/centos-binary-swift-proxy-server:current-tripleo-rdo
USER root
RUN /usr/bin/yum install -y patch
COPY swift.patch swift.patch
RUN patch -p 1 -d /usr/lib/python2.7/site-packages/swift < swift.patch
USER swift
