FROM centos:centos7  
  
RUN yum update -y  
RUN yum install -y sudo vim git curl  
RUN yum install -y epel-release  
RUN yum install -y nodejs npm  
  
RUN npm install -g n  
  
CMD [ "node" ]  
  

