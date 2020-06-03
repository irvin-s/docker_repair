FROM openjdk:8u102-jdk
MAINTAINER Carlos Sanchez <carlos@apache.org>
ENV JENKINS_SWARM_VERSION 3.12
ENV HOME /home/jenkins-slave
# install netstat to allow connection health check with
# netstat -tan | grep ESTABLISHED

RUN apt-get update && apt-get install -y net-tools && rm -rf /var/lib/apt/lists/* \
  && useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave \
  && curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

# install docker
ARG DOCKER_CLI_VERSION="18.03.1-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

RUN mkdir -p /tmp/download \
    && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
    && cp /tmp/download/docker/docker /usr/bin/docker \
    && rm -rf /tmp/download

RUN addgroup --gid 999 docker && usermod -G docker jenkins-slave

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave

VOLUME /home/jenkins-slave
ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
