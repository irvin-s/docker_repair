FROM wjax2014/java:jre-7
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV TOMCAT_MINOR_VERSION 8.0.14
ENV CATALINA_HOME /opt/tomcat

RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  wget -qO- https://www.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  tar zxf apache-tomcat-*.tar.gz && \
  rm apache-tomcat-*.tar.gz && mv apache-tomcat* ${CATALINA_HOME} && \
  rm -rf ${CATALINA_HOME}/webapps/examples \
  ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/ROOT \
  ${CATALINA_HOME}/webapps/host-manager \
  ${CATALINA_HOME}/RELEASE-NOTES ${CATALINA_HOME}/RUNNING.txt \
  ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz

RUN groupadd -r tomcat -g 4242 && \
  useradd -u 4242 -r -g tomcat -d ${CATALINA_HOME} -s /bin/bash -c "Docker image user" tomcat && \
  chown -R tomcat:tomcat ${CATALINA_HOME}

WORKDIR /opt/tomcat
EXPOSE 8080
EXPOSE 8009
VOLUME [ "/opt/tomcat/webapps", "/opt/tomcat/logs“, "/opt/tomcat/conf“, "/opt/tomcat/lib“ ]
USER tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
