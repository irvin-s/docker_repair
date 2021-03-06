# SonarQube 7.4 image with bundled sonar-scala 7.3.1 (https://github.com/mwz/sonar-scala).

FROM sonarqube:7.4-community

ENV SONAR_SCALA_VERSION 7.3.1

WORKDIR /opt/sonarqube/extensions/plugins
RUN wget -O "sonar-scala-plugin-${SONAR_SCALA_VERSION}.jar" \
    "https://dl.bintray.com/mwz/maven/com/github/mwz/sonar-scala_2.12/${SONAR_SCALA_VERSION}/sonar-scala_2.12-${SONAR_SCALA_VERSION}-assembly.jar"

WORKDIR $SONARQUBE_HOME
ENTRYPOINT ["./bin/run.sh"]
