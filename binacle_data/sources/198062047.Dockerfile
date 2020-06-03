FROM openjdk:8u171-jdk-stretch
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

ENV HOME /home/jenkins
ENV LANG en_US.UTF-8
ENV _JAVA_OPTIONS -Dfile.encoding=UTF-8

RUN useradd -c "Jenkins user" -d $HOME -m jenkins

WORKDIR /home/jenkins

COPY ssh_config .ssh/config
RUN chown jenkins.jenkins .ssh/config

USER jenkins
