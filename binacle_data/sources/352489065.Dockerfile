#
# docker run -p 8080:8080 -p 50000:50000 \
#   -v /data/jenkins:/var/jenkins \
#   --restart always \
#   --name jenkins
#

FROM docker
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

ENV JENKINS_HOME /var/jenkins
ENV JENKINS_OPTS ""
ENV JENKINS_VERSION "2.0"

WORKDIR /opt
RUN apk add --update git openjdk8-jre ttf-dejavu \
    && rm -rf /var/cache/apk/* \
    && wget http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war
RUN echo 'jenkins ALL=(ALL) NOPASSWD: /usr/local/bin/docker' >> /etc/sudoers
VOLUME  ${JENKINS_HOME}
EXPOSE 8080
EXPOSE 50000

CMD ["java", "-jar", "/opt/jenkins.war", "$JENKINS_OPTS"]
