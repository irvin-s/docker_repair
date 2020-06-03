FROM jboss/wildfly:10.0.0.Final

COPY bad.war /opt/jboss/wildfly/standalone/deployments/
