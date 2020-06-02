FROM jboss/wildfly:9.0.1.Final

RUN $JBOSS_HOME/bin/add-user.sh admin admin123! --silent

EXPOSE 8787

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-apiengine.xml", "--debug"]

# These 2 steps are latest as to invalidate as fewer layers as possible with each build
ADD t1g-distro-overlay.zip /tmp/
RUN unzip -o /tmp/t1g-distro-overlay.zip -d $JBOSS_HOME
