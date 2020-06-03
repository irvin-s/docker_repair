### Dockerfile
#
#   See https://github.com/russmckendrick/docker
#
FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV JENKINS_HOME /var/jenkins
ENV JENKINS_OPTS ""
ENV JENKINS_VERSION "latest"

WORKDIR /opt
RUN apk add --update git openjdk8-jre ttf-dejavu \
    && rm -rf /var/cache/apk/* \
    && wget http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war
VOLUME  ${JENKINS_HOME}
EXPOSE 8080
EXPOSE 50000

CMD ["java", "-jar", "/opt/jenkins.war", "$JENKINS_OPTS"]