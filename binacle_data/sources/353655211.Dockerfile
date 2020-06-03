# control-service Dockerfile
FROM clusterhq/flocker-core:1.8.0
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>

EXPOSE 4523-4524
RUN sudo bash -c "echo 'flocker-control-api 4523/tcp    # Flocker Control API port' >> /etc/services"
RUN sudo bash -c "echo 'flocker-control-agent   4525/tcp    # Flocker Control Agent port' >> /etc/services"

CMD ["/usr/sbin/flocker-control", "-p", "tcp:4523", "-a", "tcp:4524"]
