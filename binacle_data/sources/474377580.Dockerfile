FROM tomcat:7-jre8-alpine
MAINTAINER rochapaulo

ADD target/crudmicroservicesedge.war /usr/local/tomcat/webapps/crudmicroservicesedge.war

EXPOSE 8080