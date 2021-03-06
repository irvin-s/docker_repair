FROM centos:6
MAINTAINER Ross McDonald <mcdonaldrossc+docker@gmail.com>

RUN yum install -y wget && \
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    rpm -ivh epel-release-latest-6.noarch.rpm && \
    rm -f epel-release-latest-6.noarch.rpm
    
RUN yum install -y ansible

ENV PROJECT_DIR /root
RUN mkdir -p $PROJECT_DIR

WORKDIR $PROJECT_DIR
VOLUME $PROJECT_DIR
ENTRYPOINT [ "ansible-playbook", "-M", "/root", "-c", "local", "-e", "is_docker=true", "-i", "localhost," ]
