# This is a comment  
FROM centos:7  
MAINTAINER Daniel Rhodes <ohdannyboy@example.com>  
RUN yum update -y && yum install -y ruby ruby-dev  
RUN gem install sinatra  

