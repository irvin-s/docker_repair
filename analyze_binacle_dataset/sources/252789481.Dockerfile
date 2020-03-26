FROM centos:latest  
  
RUN yum update -y && yum install -y epel-release  
  
RUN yum install -y ansible ansible-lint git  

