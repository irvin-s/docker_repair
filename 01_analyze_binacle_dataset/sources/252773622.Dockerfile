FROM alizarion/java7tomcat7:latest  
  
COPY app2.war /opt/tomcat7/webapps/  
CMD /opt/tomcat7/bin/catalina.sh run  

