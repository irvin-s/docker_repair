FROM centos:centos7  
MAINTAINER Martin Hovmöller  
  
RUN yum -y install openssh-server  
  
RUN mkdir -p /var/run/sshd  
RUN groupadd --system sftp  
  
ADD . /root  
WORKDIR /root  
RUN mv sshd_config /etc/ssh/sshd_config  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  
  
EXPOSE 22  
CMD ["/bin/bash", "run"]  

