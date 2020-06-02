FROM docker.io/centos:7
LABEL maintainer="Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>"

ENV SONAR_VERSION=6.7.6 \
    SONARQUBE_HOME=/opt/sonarqube

LABEL name="SonarQube" \
      io.k8s.display-name="SonarQube" \
      io.k8s.description="Provide a SonarQube image to run on Red Hat OpenShift" \
      io.openshift.expose-services="9000" \
      io.openshift.tags="sonarqube" \
      build-date="2019-01-20" \
      version=$SONAR_VERSION \
      release="1"

USER root
EXPOSE 9000
RUN yum -y install epel-release \
    && yum repolist \
    && yum -y update \
    && yum -y install unzip java-1.8.0-openjdk nss_wrapper \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && cd /tmp \
    && curl -o sonarqube.zip -fSL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
ADD root /

RUN useradd -r sonar \
    && chmod 775 $SONARQUBE_HOME/bin/run_sonarqube.sh \
    && /usr/bin/fix-permissions /opt/sonarqube

USER sonar
WORKDIR $SONARQUBE_HOME
VOLUME $SONARQUBE_HOME/data

ENTRYPOINT ["./bin/run_sonarqube.sh"]
