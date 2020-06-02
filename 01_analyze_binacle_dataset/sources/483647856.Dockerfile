FROM martinrusev/centos:latest

ADD amon.repo /etc/yum.repos.d/amon.repo

RUN yum -t -y install amon-agent

RUN /etc/init.d/amon-agent status
RUN /etc/init.d/amon-agent test_collectors
RUN /etc/init.d/amon-agent test_plugins


CMD ["/bin/bash"]