# This Dockerfile is purely for development and testing!

FROM jboss/wildfly:9.0.1.Final

RUN $JBOSS_HOME/bin/add-user.sh admin artificer1! --silent

EXPOSE 8787

CMD ["$JBOSS_HOME/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-full.xml", "--debug"]

# These 2 steps are latest as to invalidate as fewer layers as possible with each build
COPY artificer.zip /tmp/
RUN cd /tmp \
    && bsdtar -xf /tmp/artificer.zip \
    && cd artificer \
    && ./install.sh -Ds-ramp-distro.choices.platform=1 -Ds-ramp-distro.choices.platform.jboss-wildfly-9.path=$JBOSS_HOME -Dejb-jms.password=artificer1! \
    && cp artificer-realm.json $JBOSS_HOME \
    && cd .. \
    && rm -rf artificer \
    && echo 'JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -Dkeycloak.import=$JBOSS_HOME/artificer-realm.json"' >> $JBOSS_HOME/bin/standalone.conf \
    && sed -i -e "s/Xms64m/Xms1G/g" $JBOSS_HOME/bin/standalone.conf -e "s/Xmx512m/Xmx1G/g" -e "s/MaxPermSize=256m/MaxPermSize=384m/g" $JBOSS_HOME/bin/standalone.conf