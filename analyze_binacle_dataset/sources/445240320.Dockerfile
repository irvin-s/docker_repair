FROM jboss/wildfly

LABEL maintainer="Harald Pehl <hpehl@redhat.com>"

RUN sed -i.bak 's/<server name="server-one" group="main-server-group">/<server name="server-one" group="main-server-group" auto-start="false">/' $JBOSS_HOME/domain/configuration/host.xml \
    && sed -i.bak 's/<http-interface security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm" allowed-origins="http:\/\/localhost:8888 http:\/\/localhost:3000 http:\/\/localhost:9090">/' $JBOSS_HOME/domain/configuration/host.xml \
    && sed -i.bak 's/<server name="server-two" group="main-server-group" auto-start="true">/<server name="server-two" group="main-server-group" auto-start="false">/' $JBOSS_HOME/domain/configuration/host.xml \
    && $JBOSS_HOME/bin/add-user.sh -u admin -p admin --silent

EXPOSE 8082 9992

CMD ["/opt/jboss/wildfly/bin/domain.sh", "-Djboss.http.port=8082", "-Djboss.management.http.port=9992", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
