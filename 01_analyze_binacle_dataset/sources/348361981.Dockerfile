FROM sonarqube:6.7.4-alpine

ENV SONAR_JAVA_VERSION=5.1.0.13090 \
    SONAR_FINDBUGS_VERSION=3.5.0

RUN wget -O $SONARQUBE_HOME/extensions/plugins/sonar-findbugs-plugin-$SONAR_FINDBUGS_VERSION.jar --no-verbose https://github.com/spotbugs/sonar-findbugs/releases/download/$SONAR_FINDBUGS_VERSION/sonar-findbugs-plugin.jar && \
    wget -O $SONARQUBE_HOME/extensions/plugins/sonar-java-plugin-$SONAR_JAVA_VERSION.jar --no-verbose http://central.maven.org/maven2/org/sonarsource/java/sonar-java-plugin/$SONAR_JAVA_VERSION/sonar-java-plugin-$SONAR_JAVA_VERSION.jar
COPY target/guava-helper-sonarqube-plugin-1.0.6-SNAPSHOT.jar $SONARQUBE_HOME/extensions/plugins/
