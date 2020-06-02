FROM jboss/wildfly:8.2.1.Final

RUN mkdir -p /opt/jboss/wildfly/standalone/deployments/ROOT.war/
RUN touch /opt/jboss/wildfly/standalone/deployments/ROOT.war.dodeploy

VOLUME ["/opt/jboss/wildfly/standalone/deployments/ROOT.war/"]

ENV MYSQL_CONNECTOR_VERSION 5.1.34

RUN /opt/jboss/wildfly/bin/add-user.sh -up mgmt-users.properties admin Admin#70365 --silent

# Install mysql driver
RUN curl -L -o /opt/jboss/wildfly/standalone/deployments/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.34/mysql-connector-java-5.1.34.jar

EXPOSE 8080
EXPOSE 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
