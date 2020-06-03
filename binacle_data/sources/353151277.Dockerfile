#
# Triton-optimized Mesos master
#
FROM 		misterbisson/triton-mesos:2015-07-06-triton
MAINTAINER 	Casey Bisson <casey.bisson@gmail.com>

#
# Mesos configuration
# see http://mesos.apache.org/documentation/latest/configuration/
#
ENV MESOS_CLUSTER=${MESOS_CLUSTER:-Triton-Mesos}
ENV MESOS_PORT=${MESOS_PORT:-5050}
ENV MESOS_WORK_DIR=${MESOS_WORK_DIR:-/var/lib/mesos}
ENV MESOS_ZK=${MESOS_ZK:-zk://zookeeper:2181}
ENV MESOS_QUORUM=${MESOS_QUORUM:-1}

# General configuration
ENV MESOS_HOSTNAME_LOOKUP=false

EXPOSE $MESOS_PORT

CMD ["/usr/local/sbin/mesos-master"]

