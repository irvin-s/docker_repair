FROM alpine:3.7 
MAINTAINER tomwillfixit 

RUN apk add --update \
    git \
    tini \
    openssh-client \
    curl \
    fontconfig \
    openjdk8 \
    zip \
    bash \ 
    ttf-dejavu \
 && rm /var/cache/apk/*

#Add plugin cache to reduce rebuild times
ADD plugin_cache /tmp/plugin_cache

# Set Jenkins Environment Variables
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION}

ENV JENKINS_UC https://updates.jenkins-ci.org
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

ARG JAVA_OPTS
ENV JAVA_OPTS ${JAVA_OPTS:--Xmx2048m -Djenkins.install.runSetupWizard=false}
ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log  --webroot=/var/cache/jenkins/war"

RUN echo "JENKINS_VERSION=$JENKINS_VERSION" ; echo "JAVA_OPTS=$JAVA_OPTS"

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container, 
# ensure you use the same uid
RUN addgroup -g ${gid} ${group} \
    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

# Install Jenkins
RUN echo $JENKINS_VERSION ; curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war

# Prep Jenkins Directories
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

# Install Plugins
COPY plugins.sh /usr/local/bin/plugins.sh
COPY plugins.list /usr/share/jenkins/plugins.list
RUN chmod +x  /usr/local/bin/plugins.sh
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.list

# Add groovy scripts to config master on start
# Groovy scripts will be copied to /var/jenkins_home/init.groovy.d at initialization 

ADD configuration /usr/share/jenkins/ref/init.groovy.d

COPY jenkins.sh /usr/local/bin/jenkins.sh

# jenkins.sh will start the jenkins master 
RUN chmod +x /usr/local/bin/jenkins.sh

# All files are in place. Ensure ownership is correctly set to jenkins user
RUN chown -R jenkins:jenkins "$JENKINS_HOME" /usr/share/jenkins

# Expose Ports for web, websocket and slave agents
EXPOSE 8080
EXPOSE 8081 
EXPOSE 50000 

# New to docker 1.12
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
      CMD curl http://localhost:8080 || exit 1

# Remove plugin cache
RUN rm -rf /tmp/plugin_cache

# Switch to the jenkins user
USER jenkins

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

