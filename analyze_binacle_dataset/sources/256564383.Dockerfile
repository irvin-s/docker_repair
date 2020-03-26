# LICENSE CDDL 1.0 + GPL 2.0
#
# Adapted from ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends the Oracle WebLogic image built as rhel7-weblogic-domain.
#
# It will deploy any package defined in APP_PKG_FILE located in APP_PKG_LOCATION
# into the DOMAIN_HOME with name defined in APP_NAME
#
#
# ENVIRONMENT VARIABLES
# ---------------------
#
# APP_NAME - Application name for deployment.
#
# APP_PKG_FILE - Name of war file  te deploy
#
# APP_PKG_LOCATION - default: /u01/oracle
#
#
FROM rhel7-weblogic-domain
MAINTAINER Johnathan Kupferer <jkupfere@redhat.com>

# Define variables with default values
ENV APP_NAME=${APP_NAME:-sample} \
    APP_PKG_FILE=${APP_PKG_FILE:-sample.war} \
    APP_PKG_LOCATION=${APP_PKG_LOCATION:-/u01/oracle}

# Copy files and deploy application in WLST Offline mode
COPY container-scripts/* /u01/oracle/

USER oracle
RUN wlst /u01/oracle/app-deploy.py && \
    find /u01 -user oracle -exec chmod a+rwX /u01 {} ';'
