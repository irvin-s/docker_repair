FROM tomcat:7-jre7  
MAINTAINER bkasodariya@gmail.com  
  
COPY ./ /usr/local/tomcat/webapps/sample/  
  
CMD ["catalina.sh", "run"]  

