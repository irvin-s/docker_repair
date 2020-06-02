FROM jboss/base-jdk:7

MAINTAINER Harald Pehl <hpehl@redhat.com>

# Add and unzip EAP
ADD jboss-eap-6.3.0.zip /opt/jboss/
USER root
RUN unzip /opt/jboss/jboss-eap-6.3.0.zip && mv /opt/jboss/jboss-eap-6.3 /opt/jboss/jboss-eap && rm /opt/jboss/jboss-eap-6.3.0.zip
USER jboss
ENV JBOSS_HOME=/opt/jboss/jboss-eap


# Add domain specific config files
ADD domain/configuration/* /opt/jboss/jboss-eap/domain/configuration/

# Add the docker entrypoint script
ADD entrypoint.sh /opt/jboss/jboss-eap/bin/entrypoint.sh

# Change the ownership of added files/dirs to `jboss`
USER root
RUN chown -R jboss:jboss /opt/jboss/jboss-eap
RUN chmod +x /opt/jboss/jboss-eap/bin/entrypoint.sh
USER jboss

# Default values for the environment variables used in entrypoint.sh
ENV JBOSS_EAP_MANAGEMENT_USER admin
ENV JBOSS_EAP_MANAGEMENT_PASSWORD passw0rd_

EXPOSE 8080 9990 9999

ENTRYPOINT ["/opt/jboss/jboss-eap/bin/entrypoint.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
