From tomcat:8-jre8  
EXPOSE 8080  
RUN sh -c 'touch /SpringDocker.war'  
ADD target/SpringDocker.war /usr/local/tomcat/webapps/

