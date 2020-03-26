FROM jpetazzo/dind

MAINTAINER Decheng Zhang <killercentury@gmail.com>

ENV SWARM_CLIENT_VERSION 2.0
ENV DOCKER_COMPOSE_VERSION 1.3.3

# Add a Jenkins user with permission to run docker commands
RUN useradd -r -m -G docker jenkins

# Install necessary packages
RUN apt-get update && apt-get install -y curl zip openjdk-7-jre-headless supervisor && rm -rf /var/lib/apt/lists/*

# Install Jenkins Swarm Client
RUN wget -q http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}-jar-with-dependencies.jar -P /home/jenkins

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
