FROM centos:7  
  
RUN yum -y update && \  
yum -y install epel-release && \  
yum -y install java-1.8.0-openjdk \  
java-1.8.0-openjdk-devel && \  
yum clean all  
  
ENV JAVA_HOME /usr/lib/jvm/java  

