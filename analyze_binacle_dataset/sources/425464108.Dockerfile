FROM devopsil/puppet-yum

ENV PUPPET_VERSION 5.3.5

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
