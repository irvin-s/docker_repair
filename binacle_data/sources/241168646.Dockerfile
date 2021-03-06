FROM debian:jessie-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -yq ca-certificates procps wget apt-transport-https init-system-helpers curl

WORKDIR /opt/cookbooks
RUN curl -Lo windows.tar.gz https://supermarket.chef.io/cookbooks/windows/versions/4.3.4/download && \
    tar -xzf windows.tar.gz

RUN curl -Lo /tmp/chef.deb https://packages.chef.io/files/stable/chef/14.0.190/debian/8/chef_14.0.190-1_amd64.deb && \
    dpkg -i /tmp/chef.deb

COPY tests/packaging/images/socat /bin/socat

# Insert our fake certs to the system bundle so they are trusted
COPY tests/packaging/images/certs/*.signalfx.com.* /
RUN cat /*.cert >> /etc/ssl/certs/ca-certificates.crt

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i = \   
    "systemd-tmpfiles-setup.service" ] || rm -f $i; done); \                    
    rm -f /lib/systemd/system/multi-user.target.wants/*;\ 
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Keep it from wiping our scratch dir in /tmp/scratch
RUN rm -f /usr/lib/tmpfiles.d/tmp.conf;

COPY deployments/chef /opt/cookbooks/signalfx_agent

WORKDIR /opt

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/sbin/init"]
