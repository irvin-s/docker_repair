FROM stackbrew/ubuntu:13.04
ADD etcdctl /usr/bin/etcdctl
ADD docker /usr/bin/docker
ADD libdevmapper.so.1.02 /lib/libdevmapper.so.1.02
ADD docker-reg.sh /usr/bin/docker-reg.sh
ENTRYPOINT ["/usr/bin/docker-reg.sh"]
