ARG DOCKER_REPO_NS
ARG DOCKER_BUILD_TAG
FROM ${DOCKER_REPO_NS}/zmc-base:${DOCKER_BUILD_TAG}

WORKDIR /tmp
RUN apt-get install -y zimbra-ldap

#FIXME - manual default configs and permissions should not be required outside of apt-get install
RUN [ "rsync", "-a", "--delete", "/opt/zimbra/common/etc/openldap/zimbra/config/", "/opt/zimbra/data/ldap/config" ]
RUN [ "chown", "-R", "zimbra:zimbra", "/opt/zimbra/data/ldap/config" ]
RUN [ "find", "/opt/zimbra/data/ldap/config", "-name", "*.ldif", "-exec", "chmod", "600", "{}", ";" ]
RUN [ "su", "zimbra", "-c", "/opt/zimbra/libexec/zmldapschema"]
RUN [ "mkdir", "-p", "/opt/zimbra/data/ldap/mdb/db" ]
RUN [ "chown", "-R", "zimbra:zimbra", "/opt/zimbra/data/ldap/mdb/db" ]

WORKDIR /opt/zimbra
COPY common/Zimbra/TaskDispatch.pm common/lib/perl5/Zimbra/TaskDispatch.pm
COPY common/Zimbra/DockerLib.pm common/lib/perl5/Zimbra/DockerLib.pm
COPY common/healthcheck.py healthcheck.py
COPY ldap/entry-point.pl entry-point.pl
RUN chmod +x entry-point.pl
RUN chmod +x healthcheck.py
RUN perl -c entry-point.pl

ENTRYPOINT ./entry-point.pl
EXPOSE 389 5000
