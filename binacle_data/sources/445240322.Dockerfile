FROM jboss/wildfly

MAINTAINER Harald Pehl <hpehl@redhat.com>

# Add domain specific config files
ADD domain/configuration/* /opt/jboss/wildfly/domain/configuration/

# Add the docker entrypoint script
ADD entrypoint.sh /opt/jboss/wildfly/bin/entrypoint.sh

# Change the ownership of added files/dirs to `jboss`
USER root
RUN chown -R jboss:jboss /opt/jboss/wildfly
RUN chmod +x /opt/jboss/wildfly/bin/entrypoint.sh
USER jboss

# Default values for the environment variables used in entrypoint.sh
ENV WILDFLY_MANAGEMENT_USER admin
ENV WILDFLY_MANAGEMENT_PASSWORD admin
ENV SERVER_GROUP **undefined**

EXPOSE 8080 9990 9999

ENTRYPOINT ["/opt/jboss/wildfly/bin/entrypoint.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
