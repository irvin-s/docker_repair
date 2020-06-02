ARG DOCKER_REPO_NS
ARG DOCKER_BUILD_TAG
FROM ${DOCKER_REPO_NS}/zmc-base:${DOCKER_BUILD_TAG}

WORKDIR /tmp
RUN apt-get install -y zimbra-store
RUN apt-get install -y zimbra-imapd

# special post install fixes
RUN rm -f /opt/zimbra/common/sbin/mysqld                                                           # FIXME: mysql.server should not be required with zimbra-store
RUN sed -i -e '/^\(START\|STOP\)_ORDER/ { s/\s\?mysql.server\s\?//; }' /opt/zimbra/bin/zmstorectl  # FIXME: mysql.server should not be required with zimbra-store

WORKDIR /opt/zimbra
COPY common/Zimbra/TaskDispatch.pm common/lib/perl5/Zimbra/TaskDispatch.pm
COPY common/Zimbra/DockerLib.pm common/lib/perl5/Zimbra/DockerLib.pm
COPY common/healthcheck.py healthcheck.py
COPY mailbox/entry-point.pl entry-point.pl
RUN chmod +x entry-point.pl
RUN chmod +x healthcheck.py
RUN perl -c entry-point.pl

ENTRYPOINT ./entry-point.pl
EXPOSE 110 143 993 995 80 443 8080 8443 7071 7073
