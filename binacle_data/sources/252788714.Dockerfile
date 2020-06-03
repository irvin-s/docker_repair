FROM jenkins:latest  
MAINTAINER Cuong Tran <cuong.tran@gmail.com>  
  
COPY plugins.txt /var/jenkins_home/plugins.txt  
RUN /usr/local/bin/plugins.sh /var/jenkins_home/plugins.txt  

