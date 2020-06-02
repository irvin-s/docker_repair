FROM devopsil/puppet-yum

ENV PUPPET_VERSION 4.8.2

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
