FROM mesosphere/mesos-slave:1.4.1
MAINTAINER Mesosphere <support@mesosphere.io>

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qqy \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
        ipcalc \
        linux-image-extra-virtual \
        software-properties-common \
        dmsetup \
        && \
    apt-get clean

# Install specific Docker version
ENV DOCKER_VERSION 17.05.0~ce-0~ubuntu-xenial
RUN curl -fsSL 'https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e' | apt-key add - && \
    add-apt-repository \
        "deb https://packages.docker.com/1.12/apt/repo/ \
        ubuntu-$(lsb_release -cs) \
        main" \
        && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -qqy \
        docker-engine=${DOCKER_VERSION} \
        && \
    apt-get clean

ENV WRAPPER_VERSION 0.4.0
COPY ./wrapdocker /usr/local/bin/

ENTRYPOINT ["wrapdocker"]
CMD ["mesos-slave"]
