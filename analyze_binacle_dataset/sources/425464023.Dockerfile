FROM devopsil/puppet-yum

ENV PUPPET_VERSION 2.7.8

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
