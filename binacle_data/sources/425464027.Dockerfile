FROM devopsil/puppet-yum

ENV PUPPET_VERSION 3.0.2

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
