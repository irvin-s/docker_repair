# Use latest jboss/base-jdk:8 image as the base  
FROM jaromirecek/jboss-fuse-dev:latest  
  
MAINTAINER Andrea Schiona <andrea_schiona@mytria.it>  
  
VOLUME /opt/jboss/.m2  
VOLUME /opt/jboss/jboss-fuse/instances  

