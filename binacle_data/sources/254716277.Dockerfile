FROM openjdk:8-jdk-alpine

RUN apk update \
 && apk add --no-cache \
    curl \
    bind-tools \
    bash \
    unzip \
    git \
    ca-certificates \
    dpkg \
    gnupg \
    openssl \
    openssh-client \
    ttf-dejavu \
    coreutils \
    libstdc++ \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /usr/share/jenkins/ref

ENV GOSU_VERSION 1.9
RUN set -x \
 && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && true

RUN TINI_VERSION=0.10.0 \
 && TINI_SHA=7d00da20acc5c3eb21d959733917f6672b57dabb \
 && wget https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static -O /bin/tini \
 && chmod +x /bin/tini \
 && echo "$TINI_SHA  /bin/tini" | sha1sum -c -

ARG JENKINS_VERSION
ARG JENKINS_SHA
ARG JENKINS_SLAVE_AGENT_PORT
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV JENKINS_HOME /jenkins
ENV JENKINS_SLAVE_AGENT_PORT ${JENKINS_SLAVE_AGENT_PORT:-50000}
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

VOLUME /jenkins
WORKDIR /jenkins

RUN addgroup -g ${gid} ${group} \
 && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/sh -D ${user}

RUN JENKINS_VERSION=${JENKINS_VERSION:-2.9} \
 && JENKINS_SHA=${JENKINS_SHA:-1fd02a942cca991577ee9727dd3d67470e45c031} \
 && wget https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
         -O /usr/share/jenkins/jenkins.war \
 && echo "$JENKINS_SHA  /usr/share/jenkins/jenkins.war" | sha1sum -c -

EXPOSE 8080
EXPOSE ${JENKINS_SLAVE_AGENT_PORT:-50000}

COPY jenkins/jenkins-support /usr/local/bin/jenkins-support
COPY jenkins/install-plugins.sh /usr/local/bin/install-plugins.sh

ENV JENKINS_UC https://updates.jenkins.io
RUN install-plugins.sh \
    cas-plugin \
    cloudbees-folder \
    credentials \
    cvs \
    email-ext \
    git \
    github \
    gradle \
    grails \
    groovy \
    groovy-postbuild \
    job-dsl \
    ldap \
    mailer \
    matrix-auth \
    maven-plugin \
    metrics \
    rebuild \
    sonar \
    ssh-credentials \
    startup-trigger-plugin \
    swarm \
    workflow-aggregator \
 && true

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d
COPY init.groovy.mixins /usr/share/jenkins/ref/init.groovy.mixins
COPY init.dsl.d /usr/share/jenkins/ref/init.dsl.d

ENTRYPOINT ["/bin/tini", "--", "/docker-entrypoint.sh"]
