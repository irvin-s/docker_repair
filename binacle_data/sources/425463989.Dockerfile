FROM devopsil/puppet-yum

ENV PUPPET_VERSION 2.6.14

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
