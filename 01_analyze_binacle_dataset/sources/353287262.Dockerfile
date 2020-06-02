FROM fabric8/java-centos-openjdk8-jre:1.0.0

MAINTAINER rhuss@redhat.com

EXPOSE 8080

ENV TOMCAT_VERSION 5.5.36
ENV DEPLOY_DIR /maven

# Get and Unpack Tomcat
RUN curl http://archive.apache.org/dist/tomcat/tomcat-5/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/catalina.tar.gz \
 && tar xzf /tmp/catalina.tar.gz -C /opt \
 && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
 && rm /tmp/catalina.tar.gz

# Add roles
ADD tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/

# Startup script
ADD deploy-and-run.sh /opt/apache-tomcat-${TOMCAT_VERSION}/bin/

RUN chmod 755 /opt/apache-tomcat-${TOMCAT_VERSION}/bin/deploy-and-run.sh \
 && rm -rf /opt/tomcat/webapps/balancer /opt/tomcat/webapps/jsp-examples /opt/tomcat/webapps/servlets-examples /opt/tomcat/webapps/tomcat-docs /opt/tomcat/webapps/webdav 

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

CMD /opt/tomcat/bin/deploy-and-run.sh
