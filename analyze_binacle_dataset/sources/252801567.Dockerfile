FROM centos:7  
MAINTAINER Ayub Malik <ayub.malik@gmail.com>  
  
# dutty hack as sometimes this package fails :(  
RUN yum -y remove iputils  
  
RUN yum -y update && \  
yum -y install java-1.8.0-openjdk-devel wget && \  
rm -rf /var/cache/yum/*  
  
ENV JAVA_HOME /usr/lib/jvm/java-openjdk  
  
CMD ["java", "-version"]  
  

