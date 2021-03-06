FROM ubuntu:18.04
ADD run.sh /home/run.sh

# https://docs.docker.com/compose/install/#install-compose
RUN apt-get update && \
    apt-get install -y vim curl openssh-client git wget && \
    curl -sSL https://get.docker.com/ | sh && \
    curl -L --fail https://github.com/docker/compose/releases/download/1.23.2/run.sh -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    # download and install fly CLI
    wget -O /usr/local/bin/fly https://github.com/Concourse/Concourse/releases/download/v4.2.1/fly_linux_amd64 && \
    chmod +x /usr/local/bin/fly

ENTRYPOINT ["/home/run.sh"]
