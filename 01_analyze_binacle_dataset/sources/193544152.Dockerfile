FROM openfrontier/gerrit:latest

MAINTAINER zsx <thinkernel@gmail.com>

ENV INITIAL_ADMIN_USER      admin
ENV INITIAL_ADMIN_PASSWORD  admin
ENV GERRIT_LOCAL_URL        http://localhost:8080/gerrit
ENV JENKINS_REMOTE_URL      http://jenkins:8080/jenkins

COPY gerrit-create-user.sh      /usr/local/bin/gerrit-create-user.sh
COPY gerrit-upload-ssh-key.sh   /usr/local/bin/gerrit-upload-ssh-key.sh
COPY gerrit-init.nohup          /docker-entrypoint-init.d/gerrit-init.nohup

RUN chmod +x /usr/local/bin/*.sh /docker-entrypoint-init.d/gerrit-init.nohup
