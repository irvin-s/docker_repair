FROM jboss/wildfly:8.1.0.Final

RUN $JBOSS_HOME/bin/add-user.sh admin admin123! --silent

EXPOSE 8787

ADD overlord-rtgov-dist-all-wildfly8.zip /tmp/

RUN cd $HOME \
    && bsdtar -xf /tmp/overlord-rtgov-dist-all-wildfly8.zip \
    && cd overlord-rtgov-dist-all-wildfly8 \
    && ./install.sh -Dpath=$JBOSS_HOME \
    && cp dist/governance-realm.json $JBOSS_HOME \
    && echo 'JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -Dkeycloak.import=$JBOSS_HOME/governance-realm.json"' >> $JBOSS_HOME/bin/standalone.conf \
    && cd $HOME \
    && rm -rf overlord-rtgov-dist-all-wildfly8

ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh"]
CMD ["-c", "standalone-full.xml", "--debug"]
