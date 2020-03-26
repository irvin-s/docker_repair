### Set the base image to the one built before
FROM sfaulhab/jboss-eap-6.4

### File Author / Maintainer
MAINTAINER "Sebastian Faulhaber" "sebastian.faulhaber@redhat.com"

### Add application to JBoss EAP
COPY app/ticket-monster.war $JBOSS_HOME/standalone/deployments/
