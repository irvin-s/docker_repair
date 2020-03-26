FROM cantara/alpine-zulu-jdk8

MAINTAINER Oyvind Moldestad <moldestad@gmail.com>

ENV SONAR_VERSION=6.0 \
    SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=

EXPOSE 9000

RUN apk -Uu add gnupg curl \
    && rm -rf /var/cache/apk/*

    # pub   2048R/D26468DE 2015-05-25
    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
    # uid   sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
    # sub   2048R/06855C1D 2015-05-25
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE

# Alpine Linux is missing the Name Service Switch file needed by Java for java.net.InetAddress.getLocalHost
RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf

RUN set -x \
    && mkdir /opt \
    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/*

RUN cd $SONARQUBE_HOME/extensions/plugins \
    && curl -o sonar-java-plugin-4.2.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.2.jar \
    && curl -o sonar-javascript-plugin-2.15.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.15.jar \
    && curl -o sonar-csharp-plugin-5.3.2.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-csharp-plugin/sonar-csharp-plugin-5.3.2.jar \
    && curl -o sonar-scm-git-plugin-1.2.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar \
    && curl -o sonar-scm-svn-plugin-1.3.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-1.3.jar


VOLUME ["$SONARQUBE_HOME/data", "$SONARQUBE_HOME/extensions"]

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]

