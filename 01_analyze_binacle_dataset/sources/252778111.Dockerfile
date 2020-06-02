FROM centos  
  
MAINTAINER Daniel Cordero <docker@xxoo.ws>  
  
RUN yum update -y  
RUN yum install mariadb-server -y  

