FROM tomcat:jre8  
  
MAINTAINER chehao.hsiao@gmail.com  
  
ADD readme.txt /usr/local/tomcat/webapps/  
  
EXPOSE 8080  
CMD ["catalina.sh", "run"]

