##
# A generic container for wildfly with an option of keeping application specific
# in the mapped volume. The entry point script 'wildfly-init-redhat.sh' does the
# deployment of files from the mapped volume to the $JBOSS_HOME directory.
#
# This container can be used to keep enviroment specific sensitive information
# out of Docker image so that the same image with an env specific mapped volume
# can be used to run the application for a different environment.
# 
# Example:
# $ docker build --rm -t sixturtle/wildfly-ex .
#
# 
# /opt
# +--/deployment
# +------/dev
# +----------/wildfly
# +------------/bin/init.d
# +----------------wildfly.conf    # contains environment specific sensitive values
# +------------/modules/modules/system/layers/base
# +-------------/org/postgres/main
# +-------------------module.xml
# +-------------------postgresql-9.4-1204.jdbc42.jar
# +-------------/standalone
# +---------------/configuration
# +-----------------standalone.xml # template with environment specific variables rather than actual values
# +---------------/deployment
# +-----------------your-app.war
# +------/qa
# +------/prod
#
# Environment: DEV
# $ docker run -d -p 8080:8080 -v /opt/deployment/dev/wildfly:/opt/dist/wildfly --name wildfly-dev sixturtle/wildfly-ex
# $ docker stop wildfly-dev
# $ docker start wildfly-dev
#
# Environment: QA
# $ docker run -d -p 8080:8080 -v /opt/deployment/qa/wildfly:/opt/dist/wildfly --name wildfly-qa sixturtle/wildfly-ex
# $ docker stop wildfly-qa
# $ docker start wildfly-qa
#

# FROM jboss/wildfly:8.2.0.Final
FROM sixturtle/wildfly:latest

MAINTAINER Anurag Sharma <anurag.sharma@sixturtle.com>

# Setup a distribution directory for app specific files
USER root

# Anything that is not environment specific can be packaged to the container
# with a set of defaults so that if the container is handed over to someone
# it will work.
# The environment sensitive data can be overriden via /opt/dist/wildfly/bin/init.d/wildfly.conf
#ADD ./deployment/wildfly $JBOSS_HOME/

# Map your Wildfly overlay here
RUN mkdir -p /opt/dist/wildfly

COPY ./wildfly-init-redhat.sh /
RUN chmod +x /wildfly-init-redhat.sh

USER jboss
ENTRYPOINT ["/wildfly-init-redhat.sh"]
