#upstream: https://github.com/jenkinsci/docker
FROM alpine:3.8
MAINTAINER 若虚 <slpcat@qq.com>

# Container variables
ENV \
    TERM="xterm" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    TIMEZONE="Asia/Shanghai"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

# Set timezone and locales
RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add \
           bash \
           tzdata \
           vim \
           tini \
           su-exec \
           gzip \
           tar \
           wget \
           curl \
    && echo "${TIMEZONE}" > /etc/TZ \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    # Network fix
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

# Here we install GNU libc (aka glibc) and set en_US.UTF-8 locale as default.

RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.28-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget \
        "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" \
        -O "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=191 \
    JAVA_BUILD=12 \
    JAVA_PATH=2787e4a523244c269598db4e85c51e0c \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/plugin.jar" \
           "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/jre/bin/javaws" \
           "$JAVA_HOME/jre/lib/javaws.jar" \
           "$JAVA_HOME/jre/lib/desktop" \
           "$JAVA_HOME/jre/plugin" \
           "$JAVA_HOME/jre/lib/"deploy* \
           "$JAVA_HOME/jre/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/"*jfx* \
           "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/jre/lib/amd64/libglass.so" \
           "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/jre/lib/amd64/"libjfx*.so && \
    rm -rf "$JAVA_HOME/jre/bin/jjs" \
           "$JAVA_HOME/jre/bin/keytool" \
           "$JAVA_HOME/jre/bin/orbd" \
           "$JAVA_HOME/jre/bin/pack200" \
           "$JAVA_HOME/jre/bin/policytool" \
           "$JAVA_HOME/jre/bin/rmid" \
           "$JAVA_HOME/jre/bin/rmiregistry" \
           "$JAVA_HOME/jre/bin/servertool" \
           "$JAVA_HOME/jre/bin/tnameserv" \
           "$JAVA_HOME/jre/bin/unpack200" \
           "$JAVA_HOME/jre/lib/ext/nashorn.jar" \
           "$JAVA_HOME/jre/lib/jfr.jar" \
           "$JAVA_HOME/jre/lib/jfr" \
           "$JAVA_HOME/jre/lib/oblique-fonts" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" && \
    unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" && \
    rm "${JAVA_HOME}/jre/lib/security/README.txt" && \
    apk del build-dependencies && \
    rm "/tmp/"*

RUN apk add --no-cache git openssh-client curl unzip bash ttf-dejavu coreutils tini docker

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home

ENV JENKINS_HOME $JENKINS_HOME
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p $JENKINS_HOME \
    && chown ${uid}:${gid} $JENKINS_HOME \
    && addgroup -g ${gid} ${group} \
    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME $JENKINS_HOME

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

# jenkins version being bundled in this docker image
#ENV JENKINS_VERSION ${JENKINS_VERSION:-2.150.1}

# jenkins.war checksum, download will be validated using it
#ARG JENKINS_SHA=d8ed5a7033be57aa9a84a5342b355ef9f2ba6cdb490db042a6d03efb23ca1e83

# Can be used to customize where jenkins.war get downloaded from
#http://mirrors.jenkins.io/war-stable/latest/jenkins.war
#ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
ARG JENKINS_URL=http://mirrors.jenkins.io/war-stable/latest/jenkins.war

# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war
#  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -

ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
RUN chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE ${http_port}

# will be used by attached slave agents:
EXPOSE ${agent_port}

ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

USER ${user}

COPY jenkins-support /usr/local/bin/jenkins-support
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY tini-shim.sh /bin/tini
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugins.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh
COPY install-plugins.sh /usr/local/bin/install-plugins.sh
USER root
WORKDIR /tmp

# Environment variables used throughout this Dockerfile
#
# $JENKINS_HOME     will be the final destination that Jenkins will use as its
#                   data directory. This cannot be populated before Marathon
#                   has a chance to create the host-container volume mapping.
#
ENV JENKINS_FOLDER /usr/share/jenkins

# Build Args
ARG BLUEOCEAN_VERSION=latest
ARG JENKINS_STAGING=/usr/share/jenkins/ref/
ARG CURL_RETRY=20
ARG CURL_RETRY_MAX_TIME=900

# install dependencies
RUN \
    apk update    \
    && apk add    \
       python     \
       jq         \
       git        \
       bzip2                \
       openssh-client       \
       unzip                \
       zip

# Override the default property for DNS lookup caching
RUN echo 'networkaddress.cache.ttl=60' >> ${JAVA_HOME}/jre/lib/security/java.security

RUN mkdir -p "$JENKINS_HOME" "${JENKINS_FOLDER}/war"

# jenkins setup
COPY conf/jenkins/config.xml "${JENKINS_STAGING}/config.xml"
#COPY conf/jenkins/jenkins.model.JenkinsLocationConfiguration.xml "${JENKINS_STAGING}/jenkins.model.JenkinsLocationConfiguration.xml"
#COPY conf/jenkins/nodeMonitors.xml "${JENKINS_STAGING}/nodeMonitors.xml"
#COPY conf/jenkins/hudson.model.UpdateCenter.xml "${JENKINS_HOME}/hudson.model.UpdateCenter.xml"
# lets configure Jenkins with some defaults
#COPY config/*.xml /usr/share/jenkins/ref/

# add plugins
RUN /usr/local/bin/install-plugins.sh       \
  blueocean-autofavorite:latest             \
  blueocean-commons:${BLUEOCEAN_VERSION}    \
  blueocean-config:${BLUEOCEAN_VERSION}     \
  blueocean-dashboard:${BLUEOCEAN_VERSION}  \
  blueocean-display-url:latest              \
  blueocean-events:${BLUEOCEAN_VERSION}     \
  blueocean-git-pipeline:${BLUEOCEAN_VERSION}          \
  blueocean-github-pipeline:${BLUEOCEAN_VERSION}       \
  blueocean-i18n:${BLUEOCEAN_VERSION}       \
  blueocean-jwt:${BLUEOCEAN_VERSION}        \
  blueocean-personalization:${BLUEOCEAN_VERSION}    \
  blueocean-pipeline-api-impl:${BLUEOCEAN_VERSION}  \
  blueocean-pipeline-editor:${BLUEOCEAN_VERSION}           \
  blueocean-pipeline-scm-api:${BLUEOCEAN_VERSION}   \
  blueocean-rest-impl:${BLUEOCEAN_VERSION}  \
  blueocean-rest:${BLUEOCEAN_VERSION}       \
  blueocean-web:${BLUEOCEAN_VERSION}        \
  blueocean:${BLUEOCEAN_VERSION}            \
  ace-editor:latest              \
  android-emulator:latest        \
  android-lint:latest            \
  ant:latest                     \
  ansible:latest                 \
  ansicolor:latest               \
  antisamy-markup-formatter:latest \
  artifactory:latest             \
  audit-trail:latest             \
  authentication-tokens:latest   \
  azure-credentials:latest       \
  azure-vm-agents:latest         \
  bouncycastle-api:latest        \
  branch-api:latest              \
  build-failure-analyzer:latest  \
  build-name-setter:latest       \
  build-pipeline-plugin:latest   \
  build-timeout:latest           \
  build-token-root:latest        \
  cloudbees-folder:latest        \
  credentials:latest             \
  credentials-binding:latest     \
  cloverphp:latest               \
  conditional-buildstep:latest   \
  config-file-provider:latest    \
  copyartifact:latest            \
  cvs:latest                     \
  dashboard-view:latest          \
  delivery-pipeline-plugin:latest \
  description-setter:latest      \
  dingding-notifications:latest  \
  display-url-api:latest         \
  docker-commons:latest          \
  docker-build-publish:latest    \
  docker-workflow:latest         \
  durable-task:latest            \
  ec2:latest                     \
  email-ext:latest               \
  embeddable-build-status:latest \
  external-monitor-job:latest    \
  favorite:latest                \
  ghprb:latest                   \
  git:latest                     \
  git-client:latest              \
  git-changelog:latest           \
  git-server:latest              \
  github:latest                  \
  github-api:latest              \
  github-branch-source:latest    \
  github-issues:latest           \
  github-oauth:latest            \
  github-organization-folder:latest \
  github-pullrequest:latest      \
  github-pr-coverage-status:latest \
  gitlab:latest                  \
  gitlab-hook:latest             \
  gitlab-merge-request-jenkins:latest \
  gitlab-oauth:latest            \
  gitlab-plugin:latest           \
  gradle:latest                  \
  gravatar:latest                \
  greenballs:latest              \
  handlebars:latest              \
  icon-shim:latest               \
  ivy:latest                     \
  jackson2-api:latest            \
  javadoc:latest                 \
  jenkins-multijob-plugin:latest \
  job-dsl:latest                 \
  jquery:latest                  \
  junit:latest                   \
  kerberos-sso:latest            \
  kpp-management-plugin:latest   \
  kubernetes:latest              \
  kubernetes-ci:latest           \
  kubernetes-cd:latest           \
  ldap:latest                    \
  mailer:latest                  \
  mapdb-api:latest               \
  marathon:latest                \
  matrix-auth:latest             \
  matrix-project:latest          \
  maven-plugin:latest            \
  mercurial:latest               \
  mesos:latest                   \
  metrics:latest                 \
  momentjs:latest                \
  monitoring:latest              \
  msbuild:latest                 \
  nant:latest                    \
  node-iterator-api:latest       \
  oauth-credentials:latest       \
  oic-auth:latest                \
  openshift-login:latest         \
  pam-auth:latest                \
  parameterized-trigger:latest   \
  performance:latest             \
  pipeline-build-step:latest     \
  pipeline-github-lib:latest     \
  pipeline-githubnotify-step:latest \
  pipeline-graph-analysis:latest \
  pipeline-input-step:latest     \
  pipeline-milestone-step:latest \
  pipeline-model-api:latest      \
  pipeline-model-definition:latest \
  pipeline-model-extensions:latest \
  pipeline-rest-api:latest       \
  pipeline-stage-step:latest     \
  pipeline-stage-tags-metadata:latest \
  pipeline-stage-view:latest     \ 
  pipeline-utility-steps:latest  \
  plain-credentials:latest       \
  postbuildscript:latest         \
  publish-over-cifs:latest       \
  publish-over-ftp:latest        \
  publish-over-ssh:latest        \
  pubsub-light:latest            \
  puppet:latest                  \ 
  rebuild:latest                 \
  resource-disposer:latest       \
  role-strategy:latest           \
  run-condition:latest           \
  s3:latest                      \
  saferestart:latest             \
  saml:latest                    \
  saltstack:latest               \
  scm-api:latest                 \
  script-security:latest         \
  sse-gateway:latest             \
  ssh-agent:latest               \
  ssh-credentials:latest         \
  ssh-slaves:latest              \
  ssh2easy:latest                \
  slave-setup:latest             \
  structs:latest                 \
  subversion:latest              \
  timestamper:latest             \
  token-macro:latest             \
  translation:latest             \
  uno-choice:latest              \
  url-auth-sso:latest            \
  variant:latest                 \
  view-job-filters:latest        \
  windows-slaves:latest          \
  workflow-aggregator:latest     \
  workflow-api:latest            \
  workflow-basic-steps:latest    \
  workflow-cps:latest            \
  workflow-cps-global-lib:latest \
  workflow-durable-task-step:latest \
  workflow-job:latest            \
  workflow-multibranch:latest    \
  workflow-scm-step:latest       \
  workflow-step-api:latest       \
  workflow-support:latest        \
  ws-cleanup:latest

# copy custom built plugins
#COPY plugins/*.hpi /usr/share/jenkins/ref/plugins/

# so we can use jenkins cli
#COPY config/jenkins.properties /usr/share/jenkins/ref/

# disable first-run wizard
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# remove executors in master
COPY src/main/docker/master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/

# ENV JAVA_OPTS="-Djava.util.logging.config.file=/var/jenkins_home/log.properties"
ENV JAVA_OPTS="-server -Djava.awt.headless=true -XX:MetaspaceSize=128m \
         -XX:MaxMetaspaceSize=512m -XX:ReservedCodeCacheSize=240M \
         -XX:MaxRAMFraction=2 -XshowSettings:vm -XX:+AggressiveOpts \
         -XX:-UseBiasedLocking -XX:+UseFastAccessorMethods -XX:+UnlockExperimentalVMOptions \
         -XX:+UseCGroupMemoryLimitForHeap -XX:-UseLargePages -XX:+UseG1GC \
         -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+DisableExplicitGC -XX:G1ReservePercent=25 \
         -XX:G1NewSizePercent=10 -XX:G1MaxNewSizePercent=25 -XX:MaxGCPauseMillis=20 \
         -XX:-OmitStackTraceInFastThrow -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=8 \
         -XX:MaxTenuringThreshold=1 -XX:G1HeapWastePercent=10 -XX:SurvivorRatio=8 \
         -XX:G1MixedGCCountTarget=16 -XX:G1MixedGCLiveThresholdPercent=90 \
         -XX:InitiatingHeapOccupancyPercent=35 -XX:G1HeapRegionSize=32m \
         -XX:-ResizePLAB -Djenkins.install.runSetupWizard=false -Dhudson.udp=-1 \
         -Dhudson.DNSMultiCast.disabled=true"
ENV JENKINS_OPTS="--webroot=${JENKINS_FOLDER}/war --httpListenAddress=0.0.0.0"
