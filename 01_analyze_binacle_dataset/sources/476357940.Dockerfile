FROM jboss/wildfly
ADD $app$ /opt/jboss/wildfly/standalone/deployments/ROOT.war
ENV CODENVY_APP_PORT_8080_HTTP 8080

