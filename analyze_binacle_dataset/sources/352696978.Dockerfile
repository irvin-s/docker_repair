FROM ubuntu

#
# Install docker tools and cli
#
ENV PATH "$PATH:/usr/local/bin/docker"
ENV DOCKER_CLI_VERSION "1.11.0"
ENV DOCKER_MACHINE_VERSION "v0.8.1"
ENV DOCKER_MACHINE_ONEVIEW_VERSION "v0.8.1"
ENV DOCKER_MACHINE_URL "https://github.com/docker/machine/releases/download/${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64"
ENV DOCKER_MACHINE_ONEVIEW_URL "https://github.com/HewlettPackard/docker-machine-oneview/releases/download/${DOCKER_MACHINE_ONEVIEW_VERSION}/docker-machine-driver-oneview_linux-amd64"
RUN apt-get -y update && \
    apt-get install -y curl
RUN curl -o /tmp/docker.tgz -kfsSL https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_CLI_VERSION}.tgz && \
              tar -xzvf /tmp/docker.tgz -C /usr/local/bin && \
       curl -o /usr/local/bin/docker-machine -kfsSL $DOCKER_MACHINE_URL && \
       curl -o /usr/local/bin/docker-machine-driver-oneview -kfsSL $DOCKER_MACHINE_ONEVIEW_URL && \
       chmod +x /usr/local/bin/docker-machine && \
       chmod +x /usr/local/bin/docker-machine-driver-oneview

# Copy in any built binaries
COPY bin/docker-machine* /opt/docker-machine-oneview/bin/
RUN if [ -f /opt/docker-machine-oneview/bin/docker-machine-driver-oneview_linux-amd64 ] ; then \
        cp /opt/docker-machine-oneview/bin/docker-machine-driver-oneview_linux-amd64 \
           /usr/local/bin/docker-machine-driver-oneview && \
        chmod +x /usr/local/bin/docker-machine-driver-oneview; \
        echo 'Installed docker-machine-driver-oneview from /opt/docker-machine-oneview'; \
    fi

RUN /usr/local/bin/docker/docker --version && \
    docker-machine --version
