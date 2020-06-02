FROM centos:centos7  
MAINTAINER levm "av@levm.eu"  
RUN yum -y update && yum clean all  
RUN yum -y install epel-release && yum clean all  
RUN yum -y install bind-utils pwgen nmap telnet nc \  
net-tools hostname && yum clean all  
  
CMD ["/bin/bash"]

