FROM centos:7  
LABEL name="CentOS 7 Cucumber Testing Environment" \  
vendor="CodeGnome Consulting, LTD" \  
author="Todd A. Jacobs" \  
license="GPLv3"  
  
COPY playbook.yml /etc/ansible/  
COPY vagrant.sudo /etc/sudoers.d/vagrant  
  
RUN \  
yum install -y epel-release \  
&& yum install -y ansible \  
&& ansible-galaxy install zzet.rbenv \  
&& ansible-playbook /etc/ansible/playbook.yml --connection=local  
  
USER vagrant  
WORKDIR /usr/local/src  
CMD ["/bin/bash"]  

