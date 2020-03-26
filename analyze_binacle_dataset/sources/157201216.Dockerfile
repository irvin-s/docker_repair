FROM sismics/debian-java7-jetty9
MAINTAINER benjamin.gam@gmail.com

ADD home-web/target/home-web-*.war /opt/jetty/webapps/home.war
ADD home.xml /opt/jetty/webapps/home.xml
