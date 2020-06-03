FROM inikolaev/jdk:latest

########
# Tomcat
########

# Preparation

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.35
ENV TOMCAT_HOME /etc/tomcat-${TOMCAT_VERSION}

# Installation

RUN cd /tmp
RUN wget https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mkdir tomcat-${TOMCAT_VERSION}
RUN tar -zxvf apache-tomcat-${TOMCAT_VERSION}.tar.gz --directory tomcat-${TOMCAT_VERSION} --strip-components=1
RUN mv tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME}
ENV CATALINA_HOME ${TOMCAT_HOME}
ENV PATH ${PATH}:${CATALINA_HOME}/bin

# Cleanup

RUN rm apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN unset TOMCAT_MAJOR
RUN unset TOMCAT_VERSION
RUN unset TOMCAT_HOME

# Execution

EXPOSE 8080
CMD ["catalina.sh", "run"]
