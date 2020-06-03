FROM ubuntu:14.04

MAINTAINER fabric8.io (http://fabric8.io/)

ENV GERRIT_HOME /home/gerrit
ENV GERRIT_SITE /home/gerrit/site
ENV GERRIT_TMP_DIR /home/tmp
ENV GERRIT_USER gerrit
ENV GERRIT_WAR gerrit.war
ENV GERRIT_VERSION 2.11

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y sudo vim-tiny git && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y curl

# Add user gerrit & group like also gerrit to sudo to allow the gerrit user to issue a sudo cmd
RUN groupadd $GERRIT_USER && \
    useradd -r -u 1000 -g $GERRIT_USER $GERRIT_USER

RUN mkdir ${GERRIT_HOME}

# Download Gerrit
ADD http://gerrit-releases.storage.googleapis.com/gerrit-${GERRIT_VERSION}.war ${GERRIT_HOME}/${GERRIT_WAR}

# Copy the files to bin, config & job folders
ADD ./configs ${GERRIT_HOME}/configs
ADD ./job ${GERRIT_HOME}/job
ADD ./bin ${GERRIT_HOME}/bin
RUN chmod +x ${GERRIT_HOME}/bin/conf-and-run-gerrit.sh

# Copy the plugins
ADD ./plugins ${GERRIT_HOME}/plugins

WORKDIR ${GERRIT_HOME}

EXPOSE 8080 29418
CMD ["/home/gerrit/bin/conf-and-run-gerrit.sh"]
