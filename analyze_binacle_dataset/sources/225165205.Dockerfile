FROM jenkinsci/jenkins:2.6
MAINTAINER Baptiste Mathus <batmat@batmat.net>

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

ADD seed-job/ /usr/share/jenkins/ref/jobs/_seed-job

ENV ADMIN_USERNAME admin
#default admin password : override!
ENV DEFAULT_ADMIN_PASSWORD adminjenkins
ENV ADMIN_PASSWORD $DEFAULT_ADMIN_PASSWORD

ENV DOCKER_CERTIFICATES_DIRECTORY /docker-certificates

COPY init_scripts/*.groovy  /usr/share/jenkins/ref/init.groovy.d/
