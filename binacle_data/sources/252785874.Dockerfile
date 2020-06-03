FROM centos:7  
MAINTAINER George Niculae <george.niculae79@gmail.com>  
  
COPY mongodb.repo /etc/yum.repos.d/  
  
RUN yum update && yum install -y mongodb-org && \  
chkconfig mongod on && \  
mkdir -p /data/db  
  
EXPOSE 27017  
ENTRYPOINT ["/usr/bin/mongod"]  

