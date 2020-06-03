FROM cristianokbc/centos7-epel  
MAINTAINER Cristiano Kliemann  
  
RUN yum --enablerepo=epel install -y node npm\  
&& yum clean all\  
&& npm install -g yo\  
&& npm cache clean

