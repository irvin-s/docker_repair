FROM jboss/wildfly:latest  
  
USER root  
  
RUN yum install -y epel-release && \  
yum install -y xmlstarlet && \  
yum clean all  
  
USER jboss  

