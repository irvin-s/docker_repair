FROM tomcat:latest

# Copy artefact in webapps dir
COPY target/HelloWorld.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]