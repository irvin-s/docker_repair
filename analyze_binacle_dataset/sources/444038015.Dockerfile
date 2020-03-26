FROM xeor/base-centos 

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-27

ENV DEPENDING_ENVIRONMENT_VARS SPLUNK_HOST SPLUNK_PORT

RUN yum install -y tar make && \
    curl -L https://github.com/jwilder/docker-gen/releases/download/0.3.4/docker-gen-linux-amd64-0.3.4.tar.gz > docker-gen.tgz && \ 
    tar -xvzf docker-gen.tgz && \
    yum clean all

RUN yum install -y rubygems ruby-devel gcc && \
    gem install fluentd fluent-plugin-splunk --no-ri --no-rdoc && \
    yum clean all

ADD fluentd.tmpl /

COPY init/ /init/

ENV DOCKER_HOST unix:///var/run/docker.sock
