FROM centos:centos6

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-08-10

RUN yum install -y https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum install -y wget tar

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.2/docker-gen-linux-amd64-0.3.2.tar.gz && \
    tar xvzf docker-gen-linux-amd64-0.3.2.tar.gz

ADD nginx.tmpl /

CMD ["/docker-gen", "-watch", "-only-exposed", "/nginx.tmpl", "/nginx-generated/default.conf"]

ENV DOCKER_HOST unix:///docker.sock
VOLUME /nginx-generated
