FROM jboss/wildfly

MAINTAINER Harald Pehl <hpehl@redhat.com>

# Add user
FROM jboss/wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent

# Add monitor subsystem
ADD wildfly-monitor-module.zip /tmp/
RUN unzip -q /tmp/wildfly-monitor-module.zip -d /opt/jboss/wildfly

# Add monitor specific config files
ADD standalone/configuration/* /opt/jboss/wildfly/standalone/configuration/

# Add deployments
ADD deployments/* /opt/jboss/wildfly/standalone/deployments/

# Change the ownership of added files/dirs to `jboss`
USER root
RUN chown -R jboss:jboss /opt/jboss/wildfly
USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-monitor.xml"]
