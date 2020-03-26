FROM jboss/wildfly:10.1.0.Final  
  
USER root  
  
# RUN yum update -y  
RUN ln -s $JBOSS_HOME/standalone/deployments /deployments  
  
VOLUME /deployments  
  
EXPOSE 8787  
  
  

