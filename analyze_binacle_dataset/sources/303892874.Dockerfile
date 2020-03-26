##FROM openjdk:8-jre-alpine
#FROM openjdk:8u181-jre-alpine
FROM openjdk:13-jdk-alpine
LABEL maintainer "michael@huettermann.net"

# Domain of your Artifactory. Any other storage and URI download link works, just change the ADD command, see below.
ARG ARTI
ARG VER

# Expose web port
EXPOSE 8080

# Tomcat Version
ENV TOMCAT_VERSION_MAJOR 9
ENV TOMCAT_VERSION_FULL  9.0.17

# Download, install, housekeeping
RUN apk add --update curl &&\
  apk add bash &&\
  #apk add -u libx11 &&\
  mkdir -p /opt &&\
  curl -LO ${ARTI}/list/generic-local/apache/org/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz &&\
  gunzip -c apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz | tar -xf - -C /opt &&\
  rm -f apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz &&\
  ln -s /opt/apache-tomcat-${TOMCAT_VERSION_FULL} /opt/tomcat &&\
  rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs &&\
  apk del curl &&\
  rm -rf /var/cache/apk/*

# Download and deploy the Java EE WAR
ADD http://${ARTI}/list/libs-release-local/com/huettermann/web/${VER}/all-${VER}.war /opt/tomcat/webapps/all.war

RUN chmod 755 /opt/tomcat/webapps/*.war

# Set environment
ENV CATALINA_HOME /opt/tomcat

# Start Tomcat on startup
CMD ${CATALINA_HOME}/bin/catalina.sh run