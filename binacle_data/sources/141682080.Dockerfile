FROM rossbachp/java8:latest
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -yq wget pwgen && \
  rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.11
ENV CATALINA_HOME /opt/tomcat

ENV JAVA_MAXMEMORY 256

ENV TOMCAT_MAXTHREADS 250
ENV TOMCAT_MINSPARETHREADS 4
ENV TOMCAT_HTTPTIMEOUT 20000
ENV TOMCAT_JVM_ROUTE tomcat80
ENV DEPLOY_DIR /webapps
ENV LIBS_DIR /libs
ENV PATH $PATH:$CATALINA_HOME/bin

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  wget -qO- https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  tar zxf apache-tomcat-*.tar.gz && \
  rm apache-tomcat-*.tar.gz && \
  mv apache-tomcat* ${CATALINA_HOME}

# Remove unneeded apps and files
RUN rm -rf ${CATALINA_HOME}/webapps/examples ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/ROOT ${CATALINA_HOME}/webapps/host-manager ${CATALINA_HOME}/RELEASE-NOTES ${CATALINA_HOME}/RUNNING.txt ${CATALINA_HOME}/bin/*.bat  ${CATALINA_HOME}/bin/*.tar.gz


ADD server.xml ${CATALINA_HOME}/conf/server.xml
ADD logging.properties ${CATALINA_HOME}/conf/logging.properties
ADD create_tomcat_user.sh ${CATALINA_HOME}/bin/create_tomcat_user.sh
ADD tomcat.sh ${CATALINA_HOME}/bin/tomcat.sh
RUN chmod +x ${CATALINA_HOME}/bin/*.sh

RUN groupadd -r tomcat -g 433 && \
useradd -u 431 -r -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin -c "Docker image user" tomcat && \
chown -R tomcat:tomcat ${CATALINA_HOME}

RUN apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

USER tomcat
CMD ["/opt/tomcat/bin/tomcat.sh"]
