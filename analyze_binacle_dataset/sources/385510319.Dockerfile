FROM ceph/base 
MAINTAINER franck@besnard.mobi 

RUN apt-get install -y ceph-deploy
RUN apt-get clean

RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub
ADD config /root/.ssh/config

RUN mkdir -p /home/ceph/.ssh
ADD id_rsa /home/ceph/.ssh/id_rsa
ADD id_rsa.pub /home/ceph/.ssh/id_rsa.pub
ADD config /home/ceph/.ssh/config
ADD ceph.conf /home/ceph/ceph.conf
ADD bootstrap.sh /home/ceph/bootstrap.sh
ADD init-mon.sh /home/ceph/init-mon.sh
ADD init-osd.sh /home/ceph/init-osd.sh
ADD init-mds.sh /home/ceph/init-mds.sh
RUN chown -R ceph.ceph /home/ceph/

ENTRYPOINT ["/bin/bash"]
