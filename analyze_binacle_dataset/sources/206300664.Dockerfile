FROM mesos-update
MAINTAINER Kevin Klues <klueska@mesosphere.com>

ENTRYPOINT ["mesos-master", \
            "--zk=zk://localhost:2181/mesos", \
            "--quorum=1", \
            "--work_dir=/var/lib/mesos", \
            "--log_dir=/var/log/mesos", \
            "--cluster=GPU Test Cluster"]
