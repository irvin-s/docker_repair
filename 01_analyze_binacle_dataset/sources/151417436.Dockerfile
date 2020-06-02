FROM jenkins/jenkins:2.164.3-alpine

USER root
RUN apk add --no-cache make docker

USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY jobs/seed/ /usr/share/jenkins/ref/jobs/seed/
