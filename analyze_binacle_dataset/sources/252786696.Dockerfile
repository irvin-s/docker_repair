FROM centos:7.3.1611  
RUN yum install -y openssh-server  
RUN /usr/sbin/sshd-keygen  

