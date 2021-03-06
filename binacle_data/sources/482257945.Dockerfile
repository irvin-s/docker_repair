FROM centos:7

LABEL name="crunchydata/postgres" \
        vendor="crunchy data" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="2.4.0" \
        url="https://crunchydata.com" \
        summary="Executes the pgbackrest utility, allowing FULL & DELTA restore capability." \
        description="Executes pgbackrest utility, allowing FULL, DELTA & PITR restore capability. Capable of mounting the /backrestrepo for access to pgbackrest archives, while allowing for the configuration of pgbackrest using applicable pgbackrest environment variables." \
        io.k8s.description="backrest restore container" \
        io.k8s.display-name="Crunchy backrest restore container" \
        io.openshift.expose-services="" \
        io.openshift.tags="crunchy,database"

ENV PGVERSION="11" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm" PGDG_REPO_DISABLE="pgdg10,pgdg96,pgdg95,pgdg94" \
    BACKREST_VERSION="2.13"

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update && yum -y install epel-release \
 && yum -y install  \
	hostname \
	gettext \
	nss_wrapper \
 	procps-ng  \
 && yum -y clean all

RUN yum -y install postgresql11-server  \
 && yum -y install --disablerepo="${PGDG_REPO_DISABLE}" pgbackrest-"${BACKREST_VERSION}" \
 && yum -y clean all

ENV	PGROOT="/usr/pgsql-${PGVERSION}"

# add path settings for postgres user
ADD conf/.bash_profile /var/lib/pgsql/

# set up cpm directory
RUN mkdir -p /opt/cpm/bin /opt/cpm/conf /pgdata /backrestrepo \
	/var/lib/pgsql /var/log/pgbackrest

RUN chown -R postgres:postgres /opt/cpm  \
	/pgdata /backrestrepo  \
	/var/lib/pgsql /var/log/pgbackrest

#RUN chgrp -R 0 /opt/cpm  \
#	/pgdata /backrestrepo  \
#	/var/lib/pgsql /var/log/pgbackrest && \
#    chmod -R g=u /opt/cpm  \
#	/pgdata /backrestrepo  \
#	/var/lib/pgsql /var/log/pgbackrest

# volume backrestrepo for pgbackrest to restore from and log
VOLUME /pgdata /backrestrepo

ADD bin/backrest_restore /opt/cpm/bin

#removed to allow separate version of common_lib.sh for this container only. Its in
# the bin/backrest_restore directory.
#ADD bin/common /opt/cpm/bin

ADD conf/backrest_restore /opt/cpm/conf

# Removed to rely on nss_wrapper for now
#RUN chmod g=u /etc/passwd && \
#	chmod g=u /etc/group
#
#ENTRYPOINT ["opt/cpm/bin/uid_postgres.sh"]


USER 26
CMD ["/opt/cpm/bin/start.sh"]
