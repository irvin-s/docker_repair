FROM jkremser/mini-jre:8

ENV WILDFLY_VERSION=10.1.0.Final \
    WILDFLY_SHA1=9ee3c0255e2e6007d502223916cefad2a1a5e333 \
    JBOSS_HOME=/opt/jboss/wildfly \
    LAUNCH_JBOSS_IN_BACKGROUND=true

RUN cd $HOME \
    && addgroup -S jboss \
    && adduser -S jboss -G jboss \
    && apk --update --no-cache add openssl \
    && wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p /opt/jboss \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && chown -R jboss:jboss $JBOSS_HOME \
    && apk --update --no-cache del openssl \
    && rm -rf wildfly-$WILDFLY_VERSION.tar.gz $JBOSS_HOME/docs $JBOSS_HOME/bin/client /var/cache/apk/* \
    && cd $JBOSS_HOME/bin

USER jboss

EXPOSE 8080

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
