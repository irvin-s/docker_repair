FROM docker.io/centos:6
MAINTAINER Maxim Belooussov <belooussov@gmail.com>
# TODO: add our own ssh key
# Install ansible and sshd
RUN yum -y install http://mirror.nl.leaseweb.net/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install ansible openssh-server && yum clean all
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD /usr/bin/ssh-keygen -A && /usr/sbin/sshd -D
