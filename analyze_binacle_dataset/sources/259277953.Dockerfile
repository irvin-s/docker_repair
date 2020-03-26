FROM jboss/wildfly:10.1.0.Final

# The image is maintained by the Hawkular team
MAINTAINER Hawkular <hawkular-dev@lists.jboss.org>

# The Wildfly and jolokia endpoints
EXPOSE 8080 8443 8778

# Install the agent
RUN curl -Lo $JBOSS_HOME/jolokia.jar http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.3.5/jolokia-jvm-1.3.5-agent.jar

# Modify the JAVA_OPTS so that an agent can be run
RUN echo 'JAVA_OPTS="$JAVA_OPTS -Xbootclasspath/p:/opt/jboss/wildfly/jboss-modules.jar:/opt/jboss/wildfly/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-2.0.4.Final.jar -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Djboss.modules.system.pkgs=org.jboss.byteman,org.jboss.logmanager"' >> $JBOSS_HOME/bin/standalone.conf

# Modify the JAVA_OPTS so that custom options can be run
RUN echo 'JAVA_OPTS="$JAVA_OPTS $JAVA_OPTS_APPEND"' >> $JBOSS_HOME/bin/standalone.conf

# Change the permissions so that the user running the image can start Wildfly
USER root
RUN chmod -R 777 /opt
USER 1000

CMD /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0
