FROM tomcat:8

ADD target/*.war /usr/local/tomcat/webapps
