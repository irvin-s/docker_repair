FROM centos:centos7

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-12-15

RUN yum localinstall -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && \
    yum clean all

COPY init/ /init/ 
ENTRYPOINT ["/bin/bash", "-e", "/init/start"]
CMD ["run"]

