FROM centos/ruby-23-centos7
MAINTAINER Darin London <darin.london@duke.edu>

USER root

ENV LATEST_NODE node-v0.12.7-linux-x64
ENV LATEST_NODE_URL https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz
RUN wget ${LATEST_NODE_URL} && \
    tar -zxf ${LATEST_NODE}.tar.gz && \
    mv ${LATEST_NODE}/bin/node /usr/bin/node && \
    mv ${LATEST_NODE}/bin/npm /usr/bin/npm && \
    mv ${LATEST_NODE}/lib/node_modules /usr/lib/node_modules && \
    rm -rf ${LATEST_NODE} && \
    rm ${LATEST_NODE}.tar.gz && \
    yum install --setopt=tsflags=nodocs -y --nogpgcheck postgresql postgresql-devel && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    chmod g=rw /etc/passwd

USER 1001
