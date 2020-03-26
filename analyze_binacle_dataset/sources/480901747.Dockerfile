# FROM registry.centos.org/jboss/wildfly:10.1.0.Final
FROM jboss/wildfly:10.1.0.Final
MAINTAINER George Gastaldi<ggastald@redhat.com>

ADD web/target/launchpad-missioncontrol.war /opt/jboss/wildfly/standalone/deployments/
