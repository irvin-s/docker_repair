FROM devopsil/puppet-yum

ENV PUPPET_VERSION 3.3.2

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
