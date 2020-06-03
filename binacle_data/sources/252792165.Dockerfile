FROM centos:7  
RUN yum install -y \  
sssd \  
&& yum clean all  
  
CMD ["sssd", "--interactive"]  
  
VOLUME ["/etc/sssd"]  

