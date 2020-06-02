FROM devopsil/puppet-yum

ENV PUPPET_VERSION 4.9.1

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
