FROM quay.io/openshiftio/rhel-base-jboss-jdk-8:latest
LABEL maintainer "Devtools <devtools@redhat.com>"
LABEL author "Devtools <devtools@redhat.com>"

# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
ENV LAUNCH_JBOSS_IN_BACKGROUND 1

ENV KEYCLOAK_VERSION 3.2.0.Final

# This can be specified as build argument, e.g. docker build  --build-arg OPERATING_MODE=clustered --tag IMAGE_NAME .
ARG OPERATING_MODE=clustered
ENV OPERATING_MODE ${OPERATING_MODE}

USER root

RUN chown -R 1000 /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp && \
    chmod -R ug+rw /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp
COPY ./keycloak+pmcd.sh /keycloak+pmcd.sh
EXPOSE 44321

ENV KEYCLOAK_HOME /opt/jboss/keycloak

ADD keycloak-$KEYCLOAK_VERSION.tar.gz /opt/jboss/
RUN mv /opt/jboss/keycloak-$KEYCLOAK_VERSION $KEYCLOAK_HOME

WORKDIR $KEYCLOAK_HOME

ADD standalone.xml $KEYCLOAK_HOME/standalone/configuration
ADD standalone-ha.xml $KEYCLOAK_HOME/standalone/configuration

RUN chown -R 1000:0 ${KEYCLOAK_HOME} && chmod -R ug+rw ${KEYCLOAK_HOME}

USER jboss

ADD docker-entrypoint.sh /opt/jboss/

ADD setLogLevel.xsl $KEYCLOAK_HOME
RUN java -jar /usr/share/java/saxon.jar -s:$KEYCLOAK_HOME/standalone/configuration/standalone.xml -xsl:$KEYCLOAK_HOME/setLogLevel.xsl -o:$KEYCLOAK_HOME/standalone/configuration/standalone.xml && \
    java -jar /usr/share/java/saxon.jar -s:$KEYCLOAK_HOME/standalone/configuration/standalone-ha.xml -xsl:$KEYCLOAK_HOME/setLogLevel.xsl -o:$KEYCLOAK_HOME/standalone/configuration/standalone-ha.xml && \
    rm $KEYCLOAK_HOME/setLogLevel.xsl

ADD changeDatabase.xsl $KEYCLOAK_HOME
RUN java -jar /usr/share/java/saxon.jar -s:$KEYCLOAK_HOME/standalone/configuration/standalone.xml -xsl:$KEYCLOAK_HOME/changeDatabase.xsl -o:$KEYCLOAK_HOME/standalone/configuration/standalone.xml && \
    java -jar /usr/share/java/saxon.jar -s:$KEYCLOAK_HOME/standalone/configuration/standalone-ha.xml -xsl:$KEYCLOAK_HOME/changeDatabase.xsl -o:$KEYCLOAK_HOME/standalone/configuration/standalone-ha.xml && \
    rm $KEYCLOAK_HOME/changeDatabase.xsl

ENV PSQL_JDBC_VERSION 9.3-1104-jdbc41

RUN mkdir -p $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main
ADD module-postgres-jdbc.xml $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main/
RUN cd $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main && \
  curl -O http://central.maven.org/maven2/org/postgresql/postgresql/$PSQL_JDBC_VERSION/postgresql-$PSQL_JDBC_VERSION.jar && \
  envsubst < $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main/module-postgres-jdbc.xml > $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main/module.xml && \
  rm $KEYCLOAK_HOME/modules/system/layers/base/org/postgresql/jdbc/main/module-postgres-jdbc.xml

ENV JGROUPS_K8S_VERSION 0.9.3
ENV OAUTH_VERSION 20090531

RUN mkdir -p $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main
ADD module-jgroups-k8s.xml $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main
RUN cd $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main && \
 curl -O http://central.maven.org/maven2/org/jgroups/kubernetes/kubernetes/$JGROUPS_K8S_VERSION/kubernetes-$JGROUPS_K8S_VERSION.jar && \
 curl -O http://central.maven.org/maven2/org/jgroups/kubernetes/dns/$JGROUPS_K8S_VERSION/dns-$JGROUPS_K8S_VERSION.jar && \
 curl -O http://central.maven.org/maven2/org/jgroups/kubernetes/common/$JGROUPS_K8S_VERSION/common-$JGROUPS_K8S_VERSION.jar && \
 curl -O http://central.maven.org/maven2/net/oauth/core/oauth/$OAUTH_VERSION/oauth-$OAUTH_VERSION.jar && \
 envsubst < $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main/module-jgroups-k8s.xml > $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main/module.xml && \
 rm $KEYCLOAK_HOME/modules/system/layers/base/org/jgroups/kubernetes/kubernetes/main/module-jgroups-k8s.xml && \
 sed -ie 's@\(</dependencies>\)@    <module name="org.jgroups.kubernetes.kubernetes"/>\n    \1@' /opt/jboss/keycloak/modules/system/layers/base/org/jgroups/main/module.xml


EXPOSE 8080
ENTRYPOINT [ "/keycloak+pmcd.sh" ]

CMD ["--debug", "-b", "0.0.0.0"]
