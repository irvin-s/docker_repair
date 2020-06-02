FROM devopsil/puppet:latest

# from devopsil/puppet ENV PUPPET_VERSION x.x.x

RUN yum install puppet-server-$PUPPET_VERSION -y \
    && yum clean all

ADD puppet.conf /etc/puppet/puppet.conf

VOLUME ["/opt/puppet"]

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" ]
