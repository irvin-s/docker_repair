FROM jboss/wildfly:10.1.0.Final

ADD javaee-docker-gradle.war /opt/jboss/wildfly/standalone/deployments/