FROM busybox:ubuntu-14.04

ADD ./swarm /opt/cli/swarm

ENTRYPOINT ["/opt/cli/swarm"]
