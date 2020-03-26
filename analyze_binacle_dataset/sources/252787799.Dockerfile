FROM splazit/tomcat-app  
COPY postgresql-9.4.1212.jar /usr/local/tomcat/lib/postgresql-9.4.1212.jar  
COPY ojdbc7-12.1.0.2.jar /usr/local/tomcat/lib/ojdbc7-12.1.0.2.jar  

