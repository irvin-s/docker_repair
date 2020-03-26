FROM centos:7  
MAINTAINER Castedo Ellerman <castedo@castedo.com>  
  
RUN yum update -y \  
&& yum install -y openssh-server  
  
RUN sed -e 's|^PasswordAuthentication\s*yes|PasswordAuthentication no|g' \  
-e 's|^HostKey\s*/etc/ssh/ssh_host_rsa_key|HostKey /etc/hut/ssh_host_rsa_key|g' \  
-e 's|^HostKey\s*/etc/ssh/ssh_host_ecdsa_key|HostKey /etc/hut/ssh_host_ecdsa_key|g' \  
-i /etc/ssh/sshd_config  
  
EXPOSE 22  
COPY enter-hut /root/  
  
ENTRYPOINT ["/root/enter-hut"]  
  
CMD ["/usr/sbin/sshd", "-D"]  
  

