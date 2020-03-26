FROM blacklabelops/jenkins-swarm
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Need root to build image
USER root

# install dev tools
RUN yum install -y \
      unzip \
      tar \
      gzip \
      wget && \
    yum clean all && rm -rf /var/cache/yum/*

ENV VAGRANT_HOME=/opt/vagrant

# install Hashicorp tools
RUN export PACKER_VERSION=0.10.2 && \
    export VAGRANT_VERSION=1.8.6 && \
    export OTTO_VERSION=0.2.0 && \
    export TERRAFORM_VERSION=0.7.4 && \
    export ATLAS_CLI_VERSION=0.2.0 && \
    wget --directory-prefix=/tmp https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip /tmp/packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    wget --directory-prefix=/tmp https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.rpm && \
    rpm -i /tmp/vagrant_${VAGRANT_VERSION}_x86_64.rpm && \
    wget --directory-prefix=/tmp https://releases.hashicorp.com/otto/${OTTO_VERSION}/otto_${OTTO_VERSION}_linux_amd64.zip && \
    unzip /tmp/otto_${OTTO_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    wget --directory-prefix=/tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    wget --directory-prefix=/tmp https://github.com/hashicorp/atlas-upload-cli/releases/download/v${ATLAS_CLI_VERSION}/atlas-upload-cli_${ATLAS_CLI_VERSION}_linux_amd64.tar.gz && \
    ls -All /tmp && \
    tar xzf /tmp/atlas-upload-cli_${ATLAS_CLI_VERSION}_linux_amd64.tar.gz -C /usr/local/bin && \
    mkdir -p $VAGRANT_HOME && \
    chown -R ${CONTAINER_USER}:${CONTAINER_GROUP} $VAGRANT_HOME && \
    rm -rf /tmp/*

# install Virtualbox (Example version: 5.0.14_105127_el7-1)
RUN export VIRTUALBOX_VERSION=latest && \
    mkdir -p /opt/virtualbox && \
    cd /etc/yum.repos.d/ && \
    wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo && \
    yum install -y \
      dkms \
      kernel-devel && \
    yum -y groupinstall "Development Tools" && \
    if  [ "${VIRTUALBOX_VERSION}" = "latest" ]; \
      then yum install -y VirtualBox-5.0 ; \
      else yum install -y VirtualBox-5.0-${VIRTUALBOX_VERSION} ; \
    fi && \
    yum autoremove -y \
      tar \
      unzip \
      wget && \
    yum clean all && rm -rf /var/cache/yum/*

# Switch back to user jenkins
USER $CONTAINER_UID
VOLUME $VAGRANT_HOME
