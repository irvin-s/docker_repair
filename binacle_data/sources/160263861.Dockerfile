# DOCKER-VERSION 1.2.0
# VERSION 0.1.0
# 
# rbd-lock - acquire the given lock and (optionally) store its locker value in etcd
#

FROM ulexus/rbd
MAINTAINER Seán C McCord "ulexus@gmail.com"

ADD etcdctl /usr/bin/etcdctl
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/bin/etcdctl /entrypoint.sh

# Execute the lock script
ENTRYPOINT ["/entrypoint.sh"]
