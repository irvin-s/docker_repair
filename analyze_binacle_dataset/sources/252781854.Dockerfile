FROM centos:6  
MAINTAINER Jeff Geerling  
  
# Install Ansible and other requirements.  
RUN yum makecache fast \  
&& yum -y install deltarpm epel-release \  
&& yum -y update \  
&& yum -y install \  
ansible \  
sudo \  
which \  
&& yum clean all  
  
# Disable requiretty.  
RUN sed -i -e 's/^\\(Defaults\s*requiretty\\)/#--- \1/' /etc/sudoers  
  
# Install Ansible inventory file.  
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts  
  
CMD ["/usr/sbin/init"]  

