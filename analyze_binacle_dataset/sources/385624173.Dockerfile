# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>

# Environment Variables 
ENV BPMS_HOME /opt/jboss/bpms
ENV BPMS_VERSION_MAJOR 6
ENV BPMS_VERSION_MINOR 0
ENV BPMS_VERSION_MICRO 3

ENV FUSE_HOME /opt/jboss/fuse
ENV FUSE_VERSION_MAJOR 6
ENV FUSE_VERSION_MINOR 1
ENV FUSE_VERSION_MICRO 0

# ADD Installation Files
COPY support/installation-bpms support/installation-bpms.variables installs/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar installs/jboss-fuse-full-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379.zip  /opt/jboss/

# Configure project prerequisites and run installer and cleanup installation components
RUN mkdir -p /opt/jboss/projects /opt/jboss/support/data \
  && sed -i "s:<installpath>.*</installpath>:<installpath>$BPMS_HOME</installpath>:" /opt/jboss/installation-bpms \
  && java -jar /opt/jboss/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar  /opt/jboss/installation-bpms -variablefile /opt/jboss/installation-bpms.variables \
  && rm -rf /opt/jboss/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar /opt/jboss/installation-bpms /opt/jboss/installation-bpms.variables $BPMS_HOME/jboss-eap-6.1/standalone/configuration/standalone_xml_history/ \
  && unzip -q -d $FUSE_HOME /opt/jboss/jboss-fuse-full-6.1.0.redhat-379.zip \
  && rm -rf /opt/jboss/jboss-fuse-full-6.1.0.redhat-379.zip

# Copy demo, support files and helper script
COPY projects /opt/jboss/projects
COPY support/data /opt/jboss/support/data/
COPY support/bpm-suite-demo-niogit $BPMS_HOME/jboss-eap-6.1/bin/.niogit
COPY support/application-roles.properties support/standalone.xml $BPMS_HOME/jboss-eap-6.1/standalone/configuration/
COPY support/users.properties $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379/etc/
COPY support/docker/start.sh /opt/jboss/


# Swtich back to root user to perform build and cleanup
USER root

# Adjust permissions and cleanup
RUN chown -R jboss:jboss $BPMS_HOME/jboss-eap-6.1/bin/.niogit $BPMS_HOME/jboss-eap-6.1/standalone/configuration/application-roles.properties $BPMS_HOME/jboss-eap-6.1/standalone/configuration/standalone.xml $FUSE_HOME/jboss-fuse-$FUSE_VERSION_MAJOR.$FUSE_VERSION_MINOR.$FUSE_VERSION_MICRO.redhat-379/etc/users.properties /opt/jboss/start.sh /opt/jboss/projects /opt/jboss/support \
  && chmod +x /opt/jboss/start.sh  

# Run as JBoss 
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080 8181

# Default Command
CMD ["/bin/bash"]

# Helper script
ENTRYPOINT ["/opt/jboss/start.sh"]
