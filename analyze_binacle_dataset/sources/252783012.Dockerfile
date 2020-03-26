FROM centos:7.3.1611  
RUN yum install -y java-1.8.0-openjdk && \  
yum clean all  
  
ENV JAVA_HOME /etc/alternatives/jre  

