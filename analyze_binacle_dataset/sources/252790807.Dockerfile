FROM castedo/centos:7  
MAINTAINER Castedo Ellerman <castedo@castedo.com>  
  
RUN yum update -y  
RUN yum install -y java-1.8.0-openjdk-devel  
RUN yum install -y maven  
  

