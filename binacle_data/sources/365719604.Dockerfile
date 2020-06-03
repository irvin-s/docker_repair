### Dockerfile

# Base Image: official tomcat 8 image, with jre 8 underneath
FROM tomcat:8-jre8

# Add tomcat users file for manager app
ADD container-files/tomcat-users.xml /usr/local/tomcat/conf/

# Add generated app war files to the webapps directory
ADD war/app.war /usr/local/tomcat/webapps/
ADD war/app-core.war /usr/local/tomcat/webapps/
ADD war/app-portal.war /usr/local/tomcat/webapps/

# Add context config file for the application
ADD container-files/context.xml /usr/local/tomcat/conf/

# copy logback.xml config in the container
ADD container-files/logback.xml /opt/cuba_home/

# set CATALINA_OPTS env variable to point to logback config file and app home directory
ENV CATALINA_OPTS="-Dlogback.configurationFile=/opt/cuba_home/logback.xml -Dapp.home=/opt/cuba_home"

# Add postgres jdbc driver lib
ADD https://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar /usr/local/tomcat/lib/postgresql.jar
