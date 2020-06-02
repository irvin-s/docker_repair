FROM blacklabelops/java:centos.server-jre.8
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Jenkins Swarm Version
ARG SWARM_VERSION=3.4
# Container User
ARG CONTAINER_USER=swarmslave
ARG CONTAINER_UID=1000
ARG CONTAINER_GROUP=swarmslave
ARG CONTAINER_GID=1000

# Container Internal Environment Variables
ENV SWARM_HOME=/opt/jenkins-swarm \
    SWARM_JAVA_HOME=${JAVA_HOME} \
    SWARM_WORKDIR=/opt/jenkins

RUN /usr/sbin/groupadd --gid $CONTAINER_GID $CONTAINER_GROUP && \
    /usr/sbin/useradd --uid $CONTAINER_UID --gid $CONTAINER_GID --shell /bin/bash $CONTAINER_USER && \
    # Install Development Tools
    yum install -y \
        wget \
        tar \
        gzip \
        svn \
        mercurial \
        git && \
    yum clean all && rm -rf /var/cache/yum/* && \
    # Install Git-LFS
    export GIT_LFS_VERSION=2.1.1 && \
    export GIT_LFS_SHA=b0190187cbd40ef76ff0a2d5234cc4ad1779a81b17be7cab95c53c9dea117b32dcdb639e7f5bef8aa9b5ab8b1032c3b65d86df96fdf5933d94c685ec7efec9f4 && \
    wget -O /tmp/git-lfs-linux-amd64.tar.gz https://github.com/github/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-amd64-${GIT_LFS_VERSION}.tar.gz && \
    sha512sum /tmp/git-lfs-linux-amd64.tar.gz && \
    echo "$GIT_LFS_SHA /tmp/git-lfs-linux-amd64.tar.gz" | sha512sum -c - && \
    tar xfv /tmp/git-lfs-linux-amd64.tar.gz -C /tmp && \
    cd /tmp/git-lfs-${GIT_LFS_VERSION}/ && bash -c "/tmp/git-lfs-${GIT_LFS_VERSION}/install.sh" && \
    git lfs install && \
    # Install Tini Zombie Reaper And Signal Forwarder
    export TINI_VERSION=0.14.0 && \
    export TINI_SHA=9109036722480f0b3c64f1dccef1f912d24172448b94cae7197d249e4af5b94280d3f7f5618bf9163d0b3d0745c4143675a6c3f2486fd1bfa583ca3561978b93 && \
    curl -fsSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static -o /bin/tini && \
    chmod +x /bin/tini && \
    sha512sum /bin/tini && \
    echo "$TINI_SHA /bin/tini" | sha512sum -c - && \
    # Install Jenkins Swarm-Slave
    export SWARM_SHA=28319771e0ce6bf51b8d93d73390aa33c1a926c45d93a73c02144ee7739a541c8ec5eabb345bc1d015e4b87ce531af971899d96b453dc9062ddbfa3a8fe88edb && \
    mkdir -p ${SWARM_HOME} && \
    wget --directory-prefix=${SWARM_HOME} \
      https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}.jar && \
    sha512sum ${SWARM_HOME}/swarm-client-${SWARM_VERSION}.jar && \
    echo "$SWARM_SHA ${SWARM_HOME}/swarm-client-${SWARM_VERSION}.jar" | sha512sum -c - && \
    mv ${SWARM_HOME}/swarm-client-${SWARM_VERSION}.jar ${SWARM_HOME}/swarm-client-jar-with-dependencies.jar && \
    mkdir -p ${SWARM_WORKDIR} && \
    chown -R ${CONTAINER_USER}:${CONTAINER_GROUP} ${SWARM_HOME} ${SWARM_WORKDIR} && \
    chmod +x ${SWARM_HOME}/swarm-client-jar-with-dependencies.jar

# Entrypoint Environment Variables
ENV SWARM_VM_PARAMETERS= \
    SWARM_MASTER_URL= \
    SWARM_VM_PARAMETERS= \
    SWARM_JENKINS_USER= \
    SWARM_JENKINS_PASSWORD= \
    SWARM_CLIENT_EXECUTORS= \
    SWARM_CLIENT_LABELS= \
    SWARM_CLIENT_NAME=

USER $CONTAINER_USER
WORKDIR $SWARM_WORKDIR
VOLUME $SWARM_WORKDIR
COPY imagescripts/docker-entrypoint.sh ${SWARM_HOME}/docker-entrypoint.sh
ENTRYPOINT ["/bin/tini","--","/opt/jenkins-swarm/docker-entrypoint.sh"]
CMD ["swarm"]
