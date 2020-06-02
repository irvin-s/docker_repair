FROM jboss/wildfly:8.2.1.Final
MAINTAINER Miro Cupak <mirocupak@gmail.com>

# prepare wildfly
ENV JBOSS_HOME=/opt/jboss/wildfly
ADD data $JBOSS_HOME/customization/
ADD target/*.war $JBOSS_HOME/customization

USER root

# Add mount point for certificates
RUN mkdir -p $JBOSS_HOME/customization/crt && chmod +rx $JBOSS_HOME/customization/crt

# install necessary packages
RUN yum -y install wget

# update nss and java to work around a bug with Diffie-Hellman key agreement of more than 1024 bits
RUN yum -y upgrade nss java

# download mysql driver
RUN cd /tmp
RUN wget -q http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.32/mysql-connector-java-5.1.32.jar
RUN mv *.jar $JBOSS_HOME/customization/mysql-connector-java.jar

# customize wildfly
USER $JBOSS_USER
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
ENV JAVA_OPTS "-Xms256m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true"

# default config values
ENV MYSQL_USERNAME=bob
ENV MYSQL_PASSWORD=bob
ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306
ENV MYSQL_DATABASE=bob
ENV JBOSS_BIND_ADDRESS=0.0.0.0

ENTRYPOINT ["/opt/jboss/wildfly/customization/execute.sh"]
