FROM scratch
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>
COPY swarm-cluster-state-manager /swarm-cluster-state-manager
ENTRYPOINT ["/swarm-cluster-state-manager"]
