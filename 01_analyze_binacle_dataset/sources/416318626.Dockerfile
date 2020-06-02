FROM ubuntu:14.04
MAINTAINER Puneeth Chaganti

# Add ejabberd user and group
RUN groupadd -r ejabberd \
    && useradd -r -g ejabberd -d /opt/ejabberd -s /usr/sbin/nologin ejabberd

RUN mkdir -p /opt/ejabberd/database /opt/ejabberd/ssl /opt/park

RUN chown -R ejabberd:ejabberd /opt/ejabberd/ /opt/ejabberd/database /opt/ejabberd/ssl /opt/park
RUN chmod -R 755 /opt/ejabberd/database /opt/ejabberd/ssl /opt/park

VOLUME ["/opt/ejabberd/database", "/opt/ejabberd/ssl", "/opt/park"]

USER ejabberd

