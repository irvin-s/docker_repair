FROM tomcat:8-jre8

ADD tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

# CMD ["catalina.sh", "run"]

