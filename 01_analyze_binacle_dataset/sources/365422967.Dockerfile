FROM blacklabelops/centos
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Need root to build image
USER root

# install dev tools
RUN yum install -y \
      unzip \
      tar \
      gzip \
      wget

# install Hashicorp tools
RUN export PACKER_VERSION=1.0.0 && \
    export VAGRANT_VERSION=1.9.4 && \
    export OTTO_VERSION=0.2.0 && \
    export TERRAFORM_VERSION=0.9.4 && \
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
    tar xzf /tmp/atlas-upload-cli_${ATLAS_CLI_VERSION}_linux_amd64.tar.gz -C /usr/local/bin

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
    yum clean all && rm -rf /var/cache/yum/* && rm -rf /tmp/*
