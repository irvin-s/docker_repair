FROM jenkins:1.642.1

ENV JENKINS_OPTS --httpPort=8888

USER root
RUN apt-get update && \
	apt-get install apt-transport-https ca-certificates -y && \
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
	echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-cache policy docker-engine && \
	apt-get install -y docker-engine

COPY config.groovy /usr/share/jenkins/ref/init.groovy.d/config.groovy

COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

COPY plugins-experimental.txt /usr/share/jenkins/ref/
COPY plugins-experimental.sh /usr/local/bin/
RUN /usr/local/bin/plugins-experimental.sh /usr/share/jenkins/ref/plugins-experimental.txt
