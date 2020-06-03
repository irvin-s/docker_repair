FROM tomcat:latest  
  
ADD ./petclinic.war $CATALINA_HOME/webapps/  
  
EXPOSE 8080  
CMD ["catalina.sh", "run"]  

