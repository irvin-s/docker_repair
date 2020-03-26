FROM jboss/wildfly

LABEL maintainer="Harald Pehl <hpehl@redhat.com>"

RUN sed -i.bak 's/<http-interface security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm" allowed-origins="http:\/\/localhost:8888 http:\/\/localhost:3000 http:\/\/localhost:9090">/' $JBOSS_HOME/standalone/configuration/standalone.xml \
    && sed -i.bak 's/<http-interface security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm" allowed-origins="http:\/\/localhost:8888 http:\/\/localhost:3000 http:\/\/localhost:9090">/' $JBOSS_HOME/standalone/configuration/standalone-full.xml \
    && sed -i.bak 's/<http-interface security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm" allowed-origins="http:\/\/localhost:8888 http:\/\/localhost:3000 http:\/\/localhost:9090">/' $JBOSS_HOME/standalone/configuration/standalone-ha.xml \
    && sed -i.bak 's/<http-interface security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm" allowed-origins="http:\/\/localhost:8888 http:\/\/localhost:3000 http:\/\/localhost:9090">/' $JBOSS_HOME/standalone/configuration/standalone-full-ha.xml \
    && $JBOSS_HOME/bin/add-user.sh -u admin -p admin --silent

EXPOSE 8081 9991

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-Djboss.socket.binding.port-offset=1", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone-full-ha.xml"]
