### Use the official base image from Red Hat Container Catalog (https://access.redhat.com/containers/)
FROM registry.access.redhat.com/jboss-eap-7/eap71-openshift

### File Author / Maintainer
LABEL maintainer="sebastian.faulhaber@redhat.com"

### Add application to JBoss EAP
COPY deployments/ticket-monster.war $JBOSS_HOME/standalone/deployments/
