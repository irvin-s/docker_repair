FROM ubuntu:16.04
# FROM arm=armhf/ubuntu:16.04

RUN apt-get update && \
    apt-get install -y ca-certificates wget git xz-utils && \
    rm -f /bin/sh && ln -s /bin/bash /bin/sh

ARG DAPPER_HOST_ARCH
ENV HOST_ARCH=${DAPPER_HOST_ARCH} ARCH=${DAPPER_HOST_ARCH}



ENV DOCKER_URL_amd64=https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 \
    DOCKER_URL_arm=https://github.com/rancher/docker/releases/download/v1.10.3-ros1/docker-1.10.3_arm \
    DOCKER_URL=DOCKER_URL_${ARCH}
RUN wget -O - ${!DOCKER_URL} > /usr/bin/docker && chmod +x /usr/bin/docker



ENV DOWNLOAD /usr/src

ENV KUBERNETES_DOWNLOAD https://github.com/rancher/kubernetes/releases/download/v1.10.11-rancher1/kubernetes-server-linux-amd64.tar.gz
RUN wget -O - $KUBERNETES_DOWNLOAD > $DOWNLOAD/k8s.tar.gz

ENV DAPPER_ENV REPO TAG
ENV DAPPER_SOURCE /source
ENV DAPPER_OUTPUT ./dist
ENV DAPPER_DOCKER_SOCKET true
ENV TRASH_CACHE ${DAPPER_SOURCE}/.trash-cache
WORKDIR ${DAPPER_SOURCE}

ENTRYPOINT ["./scripts/entry"]
CMD ["ci"]
