# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block, Eric D. Schabell, Duncan Doyle, Jaen Swart

# Environment Variables
ENV BRMS_HOME /opt/jboss/brms/jboss-eap-7.0
ENV BRMS_VERSION_MAJOR 6
ENV BRMS_VERSION_MINOR 4
ENV BRMS_VERSION_MICRO 0
ENV BRMS_VERSION_PATCH GA

ENV EAP_VERSION_MAJOR 7
ENV EAP_VERSION_MINOR 0
ENV EAP_VERSION_MICRO 0
#ENV EAP_VERSION_PATCH 7

ENV EAP_INSTALLER=jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO-installer.jar
ENV BRMS_DEPLOYABLE=jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.$BRMS_VERSION_PATCH-deployable-eap7.x.zip

# ADD Installation Files
COPY support/installation-eap support/installation-eap.variables installs/$BRMS_DEPLOYABLE installs/$EAP_INSTALLER /opt/jboss/

# Update Permissions on Installers
USER root
RUN chown 1000:1000 /opt/jboss/$EAP_INSTALLER /opt/jboss/$BRMS_DEPLOYABLE
USER 1000

# Prepare and run installer and cleanup installation components
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$BRMS_HOME</installpath>:" /opt/jboss/installation-eap \
	  && java -jar /opt/jboss/$EAP_INSTALLER /opt/jboss/installation-eap -variablefile /opt/jboss/installation-eap.variables \
    #&& $BRMS_HOME/bin/jboss-cli.sh --command="patch apply /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_PATCH-patch.zip --override-all" \
    && unzip -qo /opt/jboss/$BRMS_DEPLOYABLE  -d $BRMS_HOME/.. \
    && rm -rf /opt/jboss/$BRMS_DEPLOYABLE /opt/jboss/$EAP_INSTALLER /opt/jboss/installation-eap /opt/jboss/installation-eap.variables $BRMS_HOME/standalone/configuration/standalone_xml_history/


# Add support files
RUN $BRMS_HOME/bin/add-user.sh -a -r ApplicationRealm -u brmsAdmin -p jbossbrms1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent \
  && $BRMS_HOME/bin/add-user.sh -a -r ApplicationRealm -u erics -p jbossbrms1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent
COPY support/standalone.xml $BRMS_HOME/standalone/configuration/
COPY support/userinfo.properties $BRMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/

# Swtich back to root user to perform cleanup
USER root

# Fix permissions on support files
RUN chown -R 1000:1000 $BRMS_HOME/standalone/configuration/standalone.xml $BRMS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties

# Run as JBoss
USER 1000

# Expose Ports
EXPOSE 9990 9999 8080

# Run BRMS
CMD ["/opt/jboss/brms/jboss-eap-7.0/bin/standalone.sh","-c","standalone.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
