FROM devopsil/puppet-yum

ENV PUPPET_VERSION 4.10.9

RUN yum install -y puppet-$PUPPET_VERSION \
    && yum clean all
