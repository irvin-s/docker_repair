FROM amazonlinux:2

ENV container docker

RUN yum install -y systemd procps tar hostname

WORKDIR /opt/cookbooks
RUN curl -Lo windows.tar.gz https://supermarket.chef.io/cookbooks/windows/versions/4.3.4/download && \
    tar -xzf windows.tar.gz

RUN yum install -y https://packages.chef.io/files/stable/chef/12.8.1/el/7/chef-12.8.1-1.el7.x86_64.rpm

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i = \
    "systemd-tmpfiles-setup.service" ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

COPY tests/packaging/images/socat /bin/socat

# Insert our fake certs to the system bundle so they are trusted
COPY tests/packaging/images/certs/*.signalfx.com.* /
RUN cat /*.cert >> /etc/pki/tls/certs/ca-bundle.crt

COPY deployments/chef /opt/cookbooks/signalfx_agent

WORKDIR /opt

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]
