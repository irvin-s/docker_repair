FROM devopsil/puppet-yum

ENV PUPPET_VERSION 5.1.0

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
