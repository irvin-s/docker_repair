# Use latest jboss/base-jdk:7 image as the base
FROM jboss/base-jdk:8

MAINTAINER Harald Pehl <hpehl@redhat.com>

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 11.0.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Add domain specific config files
ADD domain/configuration/* /opt/jboss/wildfly/domain/configuration/

# Add the docker entrypoint script
ADD entrypoint.sh /opt/jboss/wildfly/bin/entrypoint.sh

# Change the ownership of added files/dirs to `jboss`
USER root
RUN chown -R jboss:jboss /opt/jboss/wildfly
RUN chmod +x /opt/jboss/wildfly/bin/entrypoint.sh
USER jboss

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Default values for the environment variables used in entrypoint.sh
ENV WILDFLY_MANAGEMENT_USER admin
ENV WILDFLY_MANAGEMENT_PASSWORD admin

EXPOSE 8080 9990 9999

ENTRYPOINT ["/opt/jboss/wildfly/bin/entrypoint.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
