# The build_jenkins script in jenkinz-env/commands directory will replace the OFFICIAL_IMAGE_TOKEN 
# The purpose of this build is to install the plugins we require into the official image.

FROM OFFICIAL_IMAGE_TOKEN 

USER root

# Set Jenkins Environment Variables
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

ENV JENKINS_UC https://updates.jenkins-ci.org
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

ARG JAVA_OPTS
ENV JAVA_OPTS ${JAVA_OPTS:--Xmx2048m -Djenkins.install.runSetupWizard=false}

# Install Plugins
COPY plugins.sh /usr/local/bin/plugins.sh
COPY plugins.list /usr/share/jenkins/plugins.list
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.list

# Add groovy scripts to config master on start
# Groovy scripts will be copied to /var/jenkins_home/init.groovy.d at initialization 

RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d
RUN chmod -R 777 /usr/share/jenkins/ref/init.groovy.d
COPY groovy/create_auth_token.groovy /usr/share/jenkins/ref/init.groovy.d/create_auth_token.groovy
COPY groovy/init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy
COPY groovy/tcp-slave-agent-port.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

# All files are in place. Ensure ownership is correctly set to jenkins user
RUN chown -R jenkins:jenkins "$JENKINS_HOME" /usr/share/jenkins

# Expose Ports for web, websocket and slave agents
EXPOSE 8080
EXPOSE 8081
EXPOSE 50000

USER jenkins
