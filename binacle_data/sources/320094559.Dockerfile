FROM jkremser/mini-wildfly:10.1.0.Final

ENV HAWKULAR_SERVICES_VERSION=0.30.0.Final \
    HAWKULAR_SERVICES_SHA1=3e241d9fbdcd1db6c78f16761d76391e71d67701 \
    HAWKULAR_BACKEND=cassandra \
    CASSANDRA_NODES=myCassandra \
    HAWKULAR_USER=jdoe \
    HAWKULAR_PASSWORD=password \
    HAWKULAR_AGENT_ENABLE=true \
    AS_ROOT=/opt/jboss/wildfly \
    JAVA_OPTS="-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n" \
    HAWKULAR_METRICS_TTL=14

#VOLUME ["/opt/data"]

USER root
RUN apk --update --no-cache add openssl \
    && rm -Rf /var/cache/apk/* $JBOSS_HOME \
    && touch /etc/machine-id \
    && chown -R jboss:jboss /opt/ /etc/machine-id
USER jboss

RUN cd $HOME \
    && wget https://github.com/hawkular/hawkular-services/releases/download/$HAWKULAR_SERVICES_VERSION/hawkular-services-dist-$HAWKULAR_SERVICES_VERSION.zip \
    && sha1sum hawkular-services-dist-$HAWKULAR_SERVICES_VERSION.zip | grep $HAWKULAR_SERVICES_SHA1 \
    && unzip hawkular-services-dist-$HAWKULAR_SERVICES_VERSION.zip \
    && mv $HOME/hawkular-services-dist-$HAWKULAR_SERVICES_VERSION $JBOSS_HOME \
    && mkdir -p /opt/hawkular/bin \
    && rm -Rf hawkular-services-dist-$HAWKULAR_SERVICES_VERSION.zip

COPY startcmd.sh /opt/hawkular/bin/startcmd.sh

USER root
RUN chmod +x /opt/hawkular/bin/startcmd.sh \
    && apk --update --no-cache del openssl \
    && rm -Rf /var/cache/apk/* $JBOSS_HOME/docs
USER jboss

EXPOSE 8080 8443 8787

CMD ["/opt/hawkular/bin/startcmd.sh"]
