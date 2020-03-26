FROM java:8-jdk
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

# Adapted from: https://github.com/carlossg/jenkins-swarm-slave-docker

ENV JENKINS_SWARM_VERSION 2.1

# Download swarm-client
RUN curl -fSL "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar" \
        --create-dirs -o /usr/share/jenkins/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar \
    && chmod 755 /usr/share/jenkins

# Create jenkins-slave user
RUN useradd -c "Jenkins Slave user" -d /home/jenkins-slave jenkins-slave

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
