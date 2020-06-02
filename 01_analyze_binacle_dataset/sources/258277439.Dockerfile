FROM debian:jessie

RUN apt-get update && \
    apt-get install -y wget && \
    wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/rsa.pub | apt-key add - && \
    echo deb http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.9/Debian/jessie/apt jessie main > /etc/apt/sources.list.d/gluster.list && \
    apt-get update && \
    apt-get -y install glusterfs-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/sbin/glusterd", "-N"]