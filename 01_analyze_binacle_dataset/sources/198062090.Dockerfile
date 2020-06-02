FROM jenkins/jenkins:2.167-alpine
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

USER root

# Install plugins
COPY plugins.txt /plugins.txt
COPY plugins.sh /plugins.sh
RUN /plugins.sh

ENV JENKINS_OPTS --prefix=/jenkins
ENV JENKINS_REF /usr/share/jenkins/ref/

# Skip setup wizard and add workaround for Docker plugin
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false -Djenkins.slaves.DefaultJnlpSlaveReceiver.disableStrictVerification=true -Djava.awt.headless=true
RUN echo "2.0" > $JENKINS_REF/jenkins.install.UpgradeWizard.state \
	&& echo "2.0" > $JENKINS_REF/jenkins.install.InstallUtil.lastExecVersion

# Some initial configuration
COPY config.xml org.jenkinsci.plugins.workflow.libs.GlobalLibraries.xml credentials.xml gerrit-trigger.xml jenkins.model.JenkinsLocationConfiguration.xml.override /usr/share/jenkins/ref/
COPY entrypoint.sh /usr/local/bin/
COPY jobs /usr/share/jenkins/ref/jobs

ENTRYPOINT /usr/local/bin/entrypoint.sh
