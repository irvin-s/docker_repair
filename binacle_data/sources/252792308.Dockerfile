#  
# dandelion/core-jsp-petclinic  
#  
FROM dandelion/sample-tomcat:7.0.62-jdk8  
MAINTAINER Thibault Duchateau <thibault.duchateau@gmail.com>  
  
ADD . /home/dandelion  
  
# Build the sample application  
# Deploy it to Tomcat  
# Remove sources to make the image thinner  
RUN cd /home/dandelion && \  
mvn package && \  
cp -r target/core-jsp-petclinic /usr/local/tomcat/webapps/ && \  
rm -rf /home/dandelion  

