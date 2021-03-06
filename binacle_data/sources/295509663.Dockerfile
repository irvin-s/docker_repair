FROM registry.access.redhat.com/rhel7

MAINTAINER jeff.mccormick@crunchydata.com

LABEL name="crunchydata/pgo-backrest-" \
    vendor="crunchydata.com" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="4.0.0" \
    run='docker run -d -p 8080:80 --name=web-app web-app' \
    summary="Crunchy Data PostgreSQL Operator - pgBackRest" \
    description="pgBackRest image that is integrated for use with Crunchy Data's PostgreSQL Operator."

ENV PGVERSION="11" BACKREST_VERSION="2.12"

# Crunchy Postgres repo
ADD conf/RPM-GPG-KEY-crunchydata  /
ADD conf/crunchypg11.repo /etc/yum.repos.d/
RUN rpm --import RPM-GPG-KEY-crunchydata

COPY redhat/atomic/pgo_backrest/help.1 /help.1
COPY redhat/atomic/pgo_backrest/help.md /help.md
COPY redhat/licenses /licenses

RUN yum -y --enablerepo=rhel-7-server-ose-3.11-rpms --disablerepo=crunchy* update \
 && yum -y install postgresql11-server \
 && yum -y install crunchy-backrest-"${BACKREST_VERSION}" \
 && yum -y clean all

#RUN mkdir -p /opt/cpm/bin /pgdata /backrestrepo && chown -R 26:26 /opt/cpm && chmod -R g=u /pgdata 
RUN mkdir -p /opt/cpm/bin /pgdata /backrestrepo && chown -R 26:26 /opt/cpm 
ADD bin/pgo-backrest/ /opt/cpm/bin
ADD bin/uid_postgres.sh /opt/cpm/bin

RUN chmod g=u /etc/passwd && \
        chmod g=u /etc/group

USER 26
ENTRYPOINT ["/opt/cpm/bin/uid_postgres.sh"]
VOLUME ["/pgdata","/backrestrepo"]
CMD ["/opt/cpm/bin/pgo-backrest"]
