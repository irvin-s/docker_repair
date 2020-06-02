#######################################################################
#                                                                     #
# Creates a Jenkins image with TicketMonster job configured  		  #
#                                                                     #
#######################################################################

FROM jenkins
MAINTAINER Siamak Sadeghianfar <ssadeghi@redhat.com>

# Install tar
RUN yum -y install tar

# Maven settings
ADD settings.xml /var/lib/jenkins/maven-settings.xml

# Override Jenkins settings
ADD config.xml /var/lib/jenkins/config.xml

# Jenkins Plugins
RUN wget -O /var/lib/jenkins/plugins/build-pipeline-plugin.hpi http://updates.jenkins-ci.org/download/plugins/build-pipeline-plugin/1.4.3/build-pipeline-plugin.hpi
RUN wget -O /var/lib/jenkins/plugins/jquery.hpi http://updates.jenkins-ci.org/download/plugins/jquery/1.7.2-1/jquery.hpi
RUN wget -O /var/lib/jenkins/plugins/parameterized-trigger.hpi http://updates.jenkins-ci.org/download/plugins/parameterized-trigger/2.25/parameterized-trigger.hpi
RUN wget -O /var/lib/jenkins/plugins/sonar.hpi http://updates.jenkins-ci.org/download/plugins/sonar/2.1/sonar.hpi
RUN wget -O /var/lib/jenkins/plugins/javadoc.hpi http://updates.jenkins-ci.org/download/plugins/javadoc/1.2/javadoc.hpi

# Add SonarQube Config
ADD sonar.xml /var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml

# Jenkins Jobs
RUN mkdir -p /var/lib/jenkins/jobs/ticket-monster-dev
ADD ticket-monster-dev-job.xml /var/lib/jenkins/jobs/ticket-monster-dev/config.xml

RUN mkdir -p /var/lib/jenkins/jobs/ticket-monster-systest
ADD ticket-monster-systest-job.xml /var/lib/jenkins/jobs/ticket-monster-systest/config.xml

RUN mkdir -p /var/lib/jenkins/jobs/ticket-monster-sonar
ADD ticket-monster-sonar-job.xml /var/lib/jenkins/jobs/ticket-monster-sonar/config.xml

# RUN mkdir -p /var/lib/jenkins/jobs/ticket-monster-prod
# ADD ticket-monster-prod-job.xml /var/lib/jenkins/jobs/ticket-monster-prod/config.xml

# Set the permissions
RUN chown -R jenkins:jenkins /var/lib/jenkins

# Utilities
RUN wget -O /tmp/jq http://stedolan.github.io/jq/download/linux64/jq 
RUN chmod +x /tmp/jq
RUN cp /tmp/jq /usr/bin