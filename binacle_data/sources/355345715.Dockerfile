FROM jenkins:1.651.1-alpine
MAINTAINER Praqma <info@praqma.com>

# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Prepare for creation of seed job:
# The job is created by running a custom script in /usr/share/jenkins/init.groovy.d
COPY createSeedJob.groovy /usr/share/jenkins/ref/init.groovy.d/
