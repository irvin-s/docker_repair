FROM ceph/base 
MAINTAINER franck@besnard.mobi 

RUN apt-get install -y ceph
RUN apt-get install -y ceph-mds
RUN apt-get clean

RUN mkdir -p /home/ceph/.ssh
ADD authorized_keys /home/ceph/.ssh/authorized_keys
RUN chown -R ceph.ceph /home/ceph/

