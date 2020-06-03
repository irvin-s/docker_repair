FROM registry.access.redhat.com/rhel7/rhel:latest
MAINTAINER Shea Stewart <shea.stewart@arctiq.ca>


RUN yum install -y wget && \
    yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y python-pip && \
    pip install ansible


ADD scripts/ .
RUN chmod +x sleep.sh && \
    chmod +x install_oc.sh

RUN ./install_oc.sh


CMD ["/sleep.sh"]
