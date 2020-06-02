FROM ubuntu:14.04

MAINTAINER Andrzej Raczkowski <araczkowski@gmail.com>

ARG PASSWORD
ENV PASSWORD ${PASSWORD:-secret}

# get rid of the message: "debconf: unable to initialize frontend: Dialog"
ENV DEBIAN_FRONTEND noninteractive
ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID=XE

EXPOSE 22 1521 8080

# all installation files
COPY scripts /scripts

# ! to speed up the build process - only to tests the build process !!!
# COPY files /files
# ! to speed up the build process - only to tests the build process !!!

# start the installation
RUN /scripts/install_main.sh


# ENTRYPOINT
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
