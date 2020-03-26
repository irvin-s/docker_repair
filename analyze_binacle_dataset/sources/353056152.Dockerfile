FROM rsoares/jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV EAP_VERSION=6.4
ENV JBOSS_HOME=$SOFTWARE_INSTALL_DIR/jboss-eap-$EAP_VERSION

# Create the wildfly user and group
RUN groupadd -f -r jboss -g 433 && \
    useradd -u 431 -r -g jboss -d /opt/redhat \
    -c "JBoss EAP admin user" jboss

RUN chown -R jboss.jboss $SOFTWARE_INSTALL_DIR

COPY software/*.zip         /tmp/
COPY software/patch/*   /tmp/patch/
#COPY software/eap/modules/*.zip /tmp/modules/
COPY support/applyPatch.sh  /

RUN unzip -q '/tmp/jboss-eap-*.zip' -d $SOFTWARE_INSTALL_DIR

RUN /applyPatch.sh

COPY support/*.properties    $JBOSS_HOME/standalone/configuration/
COPY support/*.properties    $JBOSS_HOME/domain/configuration/
COPY support/host-slave.xml  $JBOSS_HOME/domain/configuration/
COPY support/run.sh /

RUN rm -rf /tmp/*.zip; \
    rm -rf /tmp/patch; \
    rm -rf /tmp/modules

RUN chown -Rf jboss.jboss $SOFTWARE_INSTALL_DIR/

# See the complete list here: 
#   https://access.redhat.com/documentation/en-US/JBoss_Enterprise_Application_Platform/6.1/html/Security_Guide/Network_Ports_Used_By_JBoss_Enterprise_Application_Platform_62.html

EXPOSE 8080 9990 9999 4447 5455 7500 45700 45688 55200 54200 23364

ENTRYPOINT ["/run.sh"]
