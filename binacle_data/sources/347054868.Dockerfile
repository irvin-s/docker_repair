FROM centos:7
ADD . /root
RUN yum install -y wget
RUN cd /etc/yum.repos.d/; wget https://download.opensuse.org/repositories/home:hpcoder1/CentOS_7/home:hpcoder1.repo
RUN yum install -y scidavis xorg-x11-server-Xvfb
RUN sh /root/scidavisSmoke.sh

