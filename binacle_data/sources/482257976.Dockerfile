FROM centos:7

LABEL name="crunchydata/pgbouncer" \
	vendor="crunchy data" \
	PostgresVersion="9.6" \
	PostgresFullVersion="9.6.13" \
	Version="7.6" \
	Release="2.4.0" \
        url="https://crunchydata.com" \
        summary="Lightweight connection pooler for crunchy-postgres" \
        description="The aim of crunchy-pgbouncer is to lower the performance impact of opening new connections to PostgreSQL; clients connect through this service. It offers session, transaction and statement pooling." \
        io.k8s.description="pgbouncer container" \
        io.k8s.display-name="Crunchy pgbouncer container" \
        io.openshift.expose-services="" \
        io.openshift.tags="crunchy,database"

ENV PGVERSION="9.6" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm" PGDG_REPO_DISABLE="pgdg11,pgdg10,pgdg95,pgdg94"

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install --disablerepo="${PGDG_REPO_DISABLE}" \
      gettext \
      hostname  \
      pgbouncer \
      postgresql96 \
      procps-ng \
 && yum clean all -y

RUN mkdir -p /opt/cpm/bin /opt/cpm/conf /pgconf

ADD bin/pgbouncer /opt/cpm/bin
ADD bin/common /opt/cpm/bin
ADD conf/pgbouncer /opt/cpm/conf

RUN chown -R 2:0 /opt/cpm /pgconf && \
    chmod -R g=u /opt/cpm /pgconf

EXPOSE 6432

VOLUME ["/pgconf"]

RUN chmod g=u /etc/passwd
ENTRYPOINT ["opt/cpm/bin/uid_daemon.sh"]

USER 2

CMD ["/opt/cpm/bin/start.sh"]
