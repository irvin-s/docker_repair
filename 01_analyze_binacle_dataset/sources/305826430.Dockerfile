FROM fedora:latest

RUN dnf -y install dnf-plugins-core
RUN dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf -y install docker-ce

# Add services to test dns resolution
RUN dnf -y install sudo NetworkManager dnsmasq
RUN rpm -i https://github.com/azukiapp/libnss-resolver/releases/download/v0.3.0/fedora23-libnss-resolver-0.3.0-1.x86_64.rpm


# To use run: `docker run --privileged -it --name dind -d docker:dind` to start a docker server
# Then add `--link dind:docker` to the run of this container to connect to it
ENV DOCKER_HOST tcp://docker:2375
