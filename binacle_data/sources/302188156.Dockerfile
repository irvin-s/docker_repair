ARG DOCKER_REPO_NS
ARG DOCKER_BUILD_TAG
FROM ${DOCKER_REPO_NS}/zmc-base:${DOCKER_BUILD_TAG}

WORKDIR /tmp
RUN apt-get install -y zimbra-mta

# special post install fixes
# FIXME:
# 1. AMAVISD refuses to start if myhostname does not have [.] in its FQDN
# 2. After the services are started and are all up on the mta, zmconfigd is processing
#    some ldap update and ends up leaving amavisd in a funky state; that is, the following
#    are left not running: amavisd, zmamavisdctl. Details:
# Host zmc-mta
#         amavis                  Stopped
#                 amavisd is not running.
#         antispam                Stopped
#                 zmamavisdctl is not running
#         antivirus               Stopped
#                 zmamavisdctl is not running
#         archiving               Stopped
#                 amavisd is not running.
#                 zmamavisdctl is not running
#         mta                     Running
#         opendkim                Running
#         stats                   Running
#         zmconfigd               Running
#    
Run sed -i -e 's/\(^[$]myhostname = \)\(.\)@@/\1\2localhost\2; #/' /opt/zimbra/conf/amavisd.conf.in && \
    sed -i.bck -e 's/RESTART antivirus amavis mta/RESTART antivirus/' /opt/zimbra/conf/zmconfigd.cf

WORKDIR /opt/zimbra
COPY common/Zimbra/TaskDispatch.pm common/lib/perl5/Zimbra/TaskDispatch.pm
COPY common/Zimbra/DockerLib.pm common/lib/perl5/Zimbra/DockerLib.pm
COPY common/healthcheck.py healthcheck.py
COPY mta/entry-point.pl entry-point.pl
RUN chmod +x entry-point.pl
RUN chmod +x healthcheck.py
RUN perl -c entry-point.pl

ENTRYPOINT ./entry-point.pl
EXPOSE 25 465 587
