# open jdk 8  
#  
# VERSION 1  
FROM centos  
  
MAINTAINER craneding <crane.ding@163.com>  
  
ENV LANG en_US.UTF-8  
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  
  
#RUN yum -y upgrade  
RUN yum -y install java-1.8.0-openjdk-devel && rm -rf /var/cache/yum/*  
  
ENV JAVA_HOME /usr/lib/jvm/java-openjdk  
  
CMD ["java", "-version"]  

