
FROM centos:7

USER root

RUN yum install wget -y
# Change mirrors
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

ENV HOME /root
# Install alinode v3.11.0 (node v8.11.0)
ENV ALINODE_VERSION 3.11.0
ENV TNVM_DIR /root/.tnvm

RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash

RUN source $HOME/.bashrc \
    && tnvm install "alinode-v$ALINODE_VERSION" \
    && tnvm use "alinode-v$ALINODE_VERSION" \
    && npm install @alicloud/agenthub -g

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN rm -rf /usr/src/app/node_modules

# Build static file
RUN source $HOME/.bashrc \
    && npm install \
    && npm run build

WORKDIR /usr/src/app/server

# Build server file
RUN source $HOME/.bashrc \
   && npm install

EXPOSE 3000

RUN [ "chmod", "+x", "./docker-entrypoint.sh" ]

ENTRYPOINT [ "./docker-entrypoint.sh" ]
