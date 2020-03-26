# test-kitchen
#
# CentOS 6.5 x86_64 image fully provisioned and ready for chef test-kitchen

FROM        kintoandar/centos-6.5-x86_64:latest
MAINTAINER  Joel Bastos <kintoandar@gmail.com>

RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN useradd -d /home/kitchen -m -s /bin/bash kitchen
RUN echo kitchen:kitchen | chpasswd
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN curl -L https://www.opscode.com/chef/install.sh | bash
