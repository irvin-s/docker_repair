FROM jboss/base-jdk:8  
  
USER root  
  
RUN yum install -y epel-release && yum -y install nginx && yum clean all  
  
ENTRYPOINT nginx -g "daemon off;"  
EXPOSE 80

