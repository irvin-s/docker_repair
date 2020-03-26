FROM centos:7.3.1611  
RUN yum install -y epel-release  
RUN yum install -y ansible  
RUN yum install -y openssh-clients  
RUN yum install -y docker-client  

