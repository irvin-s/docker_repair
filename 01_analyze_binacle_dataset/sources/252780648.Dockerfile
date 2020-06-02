  
FROM centos  
  
RUN yum update -y && \  
yum install socat wget net-tools tar unzip nano epel-release -y && \  
yum clean all  
  
ENTRYPOINT ["/usr/bin/socat"]  
  

