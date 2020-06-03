FROM fedora:29

LABEL maintainer="heh@praqma.net kaz@praqma.net lel@praqma.net"

# Why Fedora as base OS?
# * Fedora always has latest packages compared to CentOS.
# * Fedora does not need extra CentOS's EPEL repositories to install tools.
# * Fedora runs as 'root', and has '/' as it's default WORKDIR.

# This Dockerfile builds a container image for Atlassian BitBucket, 
# using atlassian-bitbucket-*.bin installer. The advantage of using the bin-installer is
#   that it includes OracleJDK. We do not have to depend on Oracle Java 
#   or manage it in our image.
#
# Since this container image contains OracleJDK, we can not (re)distribute it 
#   as binary image, because of licensing issues. Though mentioning it in 
#   Dockerfile is ok.
#

# IMPORTANT: Check build-instructions.md for building this image.


################### START -  Environment variables #############################
#
#

# BITBUCKET_VERSION:
# ----------------- 
# The value for BITBUCKET_VERSION should be a version number,
#   which is part of the name of the Bitbucket software bin/tarball/zip.
ENV BITBUCKET_VERSION 6.3.0


# BITBUCKET_DOWNLOAD_URL:
# ----------------------
# User does not need to modify this ENV variable unless absolutely necessary.
ENV BITBUCKET_DOWNLOAD_URL https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BITBUCKET_VERSION}-x64.bin

# OS_USERNAME:
# -----------
# Bitbucket bin-installer automatically creates a 'atlbitbucket' user and a 'atlbitbucket' group. 
# Just make sure to specify what it's name is.
ENV OS_USERNAME atlbitbucket

# OS_GROUPNAME:
# ------------
# Bitbucket bin-installer automatically creates a 'atlbitbucket' user and a 'atlbitbucket' group. 
# Just make sure to specify what it's name is.
ENV OS_GROUPNAME atlbitbucket

# BITBUCKET_HOME:
# --------------
# Persistent directory: (need persistent storage.) This can be mounted on a OS directory mount-point.
# Need to be owned by the same UID as of user bitbucket, normally UID 1000.
# The value if this variable should be same as 'app.bitbucketHome' in the bitbucket-response.varfile file.
ENV BITBUCKET_HOME=/var/atlassian/application-data/bitbucket

# BITBUCKET_INSTALL:
# -----------------
# BitBucket Installation files: (persistent storage NOT needed)
# This ENV var is important to set here, as it is used by docker-entry.sh script at container startup.
# The value if this variable should be same as 'app.defaultInstallDir' in the bitbucket-response.varfile file.
ENV BITBUCKET_INSTALL=/opt/atlassian/bitbucket

# TZ_FILE:
# -------
# This is the timezone file to use for the container.
# Timezone files are normally found in /usr/share/zoneinfo/* .
# Use correct zone for the container image.
ENV TZ_FILE "/usr/share/zoneinfo/Europe/Oslo"

# JAVA_HOME:
# ---------
ENV JAVA_HOME /opt/atlassian/bitbucket/jre

# JAVA_OPTS:
# ---------
# Optional values you want to pass as JAVA_OPTS. You can pass Java memory parameters to this variable,
#    but in newer versionso of Atlassian software, memory settings are done in CATALINA_OPTS.
# JAVA_OPTS  "-Dsome.javaSetting=somevalue"
# ENV JAVA_OPTS "-Dhttp.nonProxyHosts=bitbucket.example.com"

# CATALINA_OPTS:
# -------------
# CATLINA_OPTS will be used by BITBUCKET_INSTALL/bin/setenv.sh script .
# You can use this to setup internationalization options and also any Java memory settings.
# It is a good idea to use same value for -Xms and -Xmx to avoid frequence shrinking and expanding of Java memory.
# In the example below it is set to 2 GB. It should always be half (or less) of physical RAM of the server/node/pod/container.
ENV CATALINA_OPTS "-Dfile.encoding=UTF-8 -Xms1024m -Xmx1024m"

# ENABLE_CERT_IMPORT:
# ------------------
# Allow import of user defined certificates.
ENV ENABLE_CERT_IMPORT false

# SSL_CERTS_PATH:
# --------------
# If you have self signed certificates, you need to force Atlassian applications to trust those certs.
# Very useful when different atlassian applications need to talk to each other.
# This should be a path which you either volume-mount in docker or k8s.
ENV SSL_CERTS_PATH /var/atlassian/ssl


# PLUGINS_FILE (BitBucket plugins):
# --------------------------------
# Any additional bitbucket plugins you need to install should be listed in file named `bitbucket-plugins.list` - one at each line.
# Then mount that file at container-runtime at the location you specified in PLUGINS_FILE environment variable.
# This also means that you can control the location and name of this file just by controlling this variable.
# The following specifies the path of this file **inside** the container. It is later used by docker-entrypoint.sh.
ENV PLUGINS_FILE /tmp/bitbucket-plugins.list

# ELASTICSEARCH_ENABLED
# Set 'false' to prevent Elasticsearch from starting in the container. 
# This should be used if Elasticsearch is running remotely, e.g. for if Bitbucket is running in a Data Center cluster.
ENV ELASTICSEARCH_ENABLED false


# DATACENTER_MODE:
# ---------------
# This needs to be set to true if you want to setup Bitbucket in a data-center mode.
ENV DATACENTER_MODE false

# BITBUCKET_DATACENTER_SHARE:
# --------------------------
# This is only used in DataCenter mode. It needs to be a shared location, which multiple Bitbucket instances can write to.
# This location will most probably be an NFS share, and should exist on the file system.
# If it does not exist, then it will be created and chown to the Bitbucket OS user.
# NB: For this to work, DATA_CENTER_MODE should be set to true.
# ENV BITBUCKET_DATACENTER_SHARE /var/atlassian/bitbucket-datacenter
ENV BITBUCKET_DATACENTER_SHARE /mnt/shared


# Reverse proxy specific environment variables:
# ============================================
# Reference: README.md at https://bitbucket.org/atlassian-docker/docker-atlassian-bitbucket-server/src/base-6/
# This applies to BitBucket version 5+ . These variables are:

# SERVER_SECURE:
# -------------
# This should be set to true if SERVER_SCHEME (below) is set to https.
# Otherwise, it should be set to false (default).
# ENV SERVER_SECURE false

# SERVER_SCHEME:
# -------------
# The scheme used by the internet facing proxy (normally https)
# ENV SERVER_SCHEME https

# SERVER_PROXY_PORT:
# -----------------
# The public facing port, not the bitbucket container port
# ENV SERVER_PROXY_PORT 443

# SERVER_PROXY_NAME:
# -----------------
# The FQDN used by anyone accessing bitbucket from outside (i.e. The FQDN of the proxy server/ingress controller):
# ENV SERVER_PROXY_NAME=<Your url here>
# ENV SERVER_PROXY_NAME=bitbucket.example.com


# SERVER_CONTEXT_PATH:
# -------------------
# Normally you do not need to change the context-path, and if undefined, it is set to '/' by default.
# ENV SERVER_CONTEXT_PATH="/"

#
#
####################################### END - Environment variables #######################################

########################################### START - Build image #####################################
#
#

# Internaltionalization / i18n - Notes on OS settings (Fedora):
# ------------------------------------------------------------
# Note the file '/etc/sysconfig/i18n' does not exist by default
# RUN echo -e "LANG=\"en_US.UTF-8\" \n LC_ALL=\"en_US.UTF-8\"" > /etc/sysconfig/i18n
# RUN echo -e "LANG=\"en_US.UTF-8\" \n LC_ALL=\"en_US.UTF-8\"" > /etc/locale.conf

# Internaltionalization / i18n - Notes on OS settings (Debian):
# ------------------------------------------------------------
# RUN echo -e "LANG=\"en_US.UTF-8\" \n LC_ALL=\"en_US.UTF-8\"" > /etc/default/locale

# Unattended installation mode also allows you to supply a response file with a -varfile option, 
#   to supply answers for all questions that are used instead of the defaults.
# https://confluence.atlassian.com/bitbucketserver/running-the-bitbucket-server-installer-776640183.html#RunningtheBitbucketServerinstaller-Consoleandunattendedmode
# Bitbucket response file is used for unattended installation using atlassian-bitbucket-*.bin installer.
COPY bitbucket-response.varfile /tmp/


# Combine several steps in a single RUN to reduce the image size:
# --------------------------------------------------------------

# We install some tools. We need:
# * xmlstarlet to modify XML files though.
# * latest git to be able to install bitbucket
# * gunzip, hostname , ps are  needed by bitbucket installer.
# * 'which' is used by the installer to find the location of gunzip
# * iproute gives us 'ss' newer alternative for netstat.

# Download Bitbucket Software: (gets downloaded in '/'):
# -----------------------------------------------------
# https://www.atlassian.com/software/bitbucket/downloads/binary/atlassian-bitbucket-${BITBUCKET_VERSION}-x64.bin
# The 'sync' is important for some reason. Otherwise dockerhub fails to build the image.

# Sometimes the installer fails for whatever reason.
# So during development time, it is best to separate the download step from the install step.

# Chown the BITBUCKET_INSTALL directory, so we can edit files there later (such as server.xml), as user bitbucket.
# The BITBUCKET_HOME is already setup by the installer to be owned by Bitbucket user.
RUN echo -e "LANG=\"en_US.UTF-8\" \n LC_ALL=\"en_US.UTF-8\"" > /etc/sysconfig/i18n \
  && echo -e "LANG=\"en_US.UTF-8\" \n LC_ALL=\"en_US.UTF-8\"" > /etc/locale.conf \
  && yum -y install findutils which gzip hostname procps iputils bind-utils iproute jq  git dejavu-sans-fonts \
  && sync \
  && yum -y clean all \
  && ln -sf ${TZ_FILE} /etc/localtime \
  && echo "Downloading BitBucket version ${BITBUCKET_VERSION} from: ${BITBUCKET_DOWNLOAD_URL}" \
  && curl -# -O -L ${BITBUCKET_DOWNLOAD_URL} \
  && sync \
  && chmod +x atlassian-bitbucket-${BITBUCKET_VERSION}-x64.bin \
  && ./atlassian-bitbucket-${BITBUCKET_VERSION}-x64.bin -q -varfile /tmp/bitbucket-response.varfile \
  && sync \
  && rm atlassian-bitbucket-${BITBUCKET_VERSION}-x64.bin \
  && if [ ! -z "${BITBUCKET_DATACENTER_SHARE}" ] && [ ! -d "${BITBUCKET_DATACENTER_SHARE}" ]; then mkdir ${BITBUCKET_DATACENTER_SHARE}; fi \
  && if [ ! -z "${BITBUCKET_DATACENTER_SHARE}" ] && [ -d "${BITBUCKET_DATACENTER_SHARE}" ]; then chown -R ${OS_USERNAME}:${OS_GROUPNAME} ${BITBUCKET_DATACENTER_SHARE}; fi \
  && chown -R ${OS_USERNAME}:${OS_GROUPNAME} ${BITBUCKET_INSTALL} ${BITBUCKET_HOME} \
  && HOME_DIR=$(grep ${OS_USERNAME} /etc/passwd | cut -d ':' -f 6) \
  && cp /etc/localtime ${HOME_DIR}/ \
  && chown ${OS_USERNAME}:${OS_GROUPNAME} ${HOME_DIR}/localtime \
  && ln -sf ${HOME_DIR}/localtime /etc/localtime \
  && sync \
  && if [ -n "${SSL_CERTS_PATH}" ] && [ ! -d "${SSL_CERTS_PATH}" ]; then mkdir -p ${SSL_CERTS_PATH}; fi \
  && if [ -n "${SSL_CERTS_PATH}" ] && [ -d "${SSL_CERTS_PATH}" ]; then chown ${OS_USERNAME}:${OS_GROUPNAME} ${SSL_CERTS_PATH}; fi \
  && sync



# Copy the entry point to / path.
COPY docker-entrypoint.sh /


# Expose default HTTP connector port.
EXPOSE 7990/tcp

# Expose the SSH port.
EXPOSE 7999/tcp

# Change the the default working directory from '/' to '/var/atlassian/application-data/bitbucket'
WORKDIR ${BITBUCKET_HOME}

# Set the default user for the image/container to user 'atlbitbucket'.
#   Bitbucket software will be run as this user & group.
#   USER ${OS_USER_NAME}:${OS_USER_GROUP}
# USER atlbitbucket:atlbitbucket
USER ${OS_USERNAME}:${OS_GROUPNAME}

# Persistent volumes:
# Set volume mount points for installation and home directory.
# Changes to the home directory needs to be persisted.
# Optionally, changes to parts of the installation directory also need persistence, eg. logs.
VOLUME ["${BITBUCKET_HOME}", "${BITBUCKET_INSTALL}/logs"]

ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian Bitbucket as a foreground process by default, using our modified startup script.
# The CMD command does not take environment variable, so it has to be a fixed path.

CMD ["/opt/atlassian/bitbucket/bin/start-bitbucket.sh", "-fg"]

#
#
########################################### END - Build image ###########################################



