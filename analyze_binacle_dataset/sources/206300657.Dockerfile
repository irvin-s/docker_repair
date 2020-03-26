FROM marathon-update
MAINTAINER Kevin Klues <klueska@mesosphere.com>

ENTRYPOINT ["/marathon/bin/start", \
            "--master", "zk://localhost:2181/mesos", \
            "--zk", "zk://localhost:2181/marathon"]
