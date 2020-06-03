FROM jboss/switchyard-wildfly:2.0.0.Beta1

RUN $JBOSS_HOME/bin/add-user.sh admin admin123! --silent

EXPOSE 8787

ADD overlord-rtgov-dist-client-wildfly8.zip /tmp/

RUN cd $HOME \
    && bsdtar -xf /tmp/overlord-rtgov-dist-client-wildfly8.zip \
    && cd overlord-rtgov-dist-client-wildfly8 \
    && ./install.sh -Dpath=$JBOSS_HOME \
    && echo 'JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0"' >> $JBOSS_HOME/bin/standalone.conf \
    && cd $HOME \
    && rm -rf overlord-rtgov-dist-client-wildfly8 \
    && sed -i -e "s/https:\/\/rtgovserver.com:8443/http:\/\/rtgovserver:8080/g" $JBOSS_HOME/standalone/configuration/overlord-rtgov.properties \
    && sed -i -e "s/serverPassword=admin:8443/serverPassword=admin/g" $JBOSS_HOME/standalone/configuration/overlord-rtgov.properties


ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh"]
CMD []
