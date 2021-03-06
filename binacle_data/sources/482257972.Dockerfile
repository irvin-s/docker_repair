FROM centos:7

LABEL name="crunchydata/collect" \
        vendor="crunchy data" \
	PostgresVersion="9.6" \
	PostgresFullVersion="9.6.13" \
	Version="7.6" \
	Release="2.4.0" \
        url="https://crunchydata.com" \
        summary="Provides metrics for crunchy-postgres" \
        description="Run with crunchy-postgres, crunchy-collect reads the Postgres data directory and has a SQL interface to a database to allow for metrics collection. Used in conjunction with crunchy-prometheus and crunchy-grafana." \
        io.k8s.description="collect container" \
        io.k8s.display-name="Crunchy collect container" \
        io.openshift.expose-services="" \
        io.openshift.tags="crunchy,database"

ENV PGVERSION="9.6" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm"

# Install the PGDG yum repo
RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

# Install postgres client tools and libraries
RUN yum install -y epel-release \
  && yum -y update \
  && yum -y install \
    gettext \
    postgresql96 \
    postgresql96-libs \
  && yum -y clean all

RUN mkdir -p /opt/cpm/bin /opt/cpm/conf

ADD postgres_exporter.tar.gz /opt/cpm/bin
ADD tools/pgmonitor/exporter/postgres /opt/cpm/conf
ADD bin/collect /opt/cpm/bin
ADD bin/common /opt/cpm/bin
ADD conf/collect /opt/cpm/conf

RUN chgrp -R 0 /opt/cpm/bin /opt/cpm/conf && \
    chmod -R g=u /opt/cpm/bin/ opt/cpm/conf

VOLUME ["/conf"]

# postgres_exporter
EXPOSE 9187

RUN chmod g=u /etc/passwd

ENTRYPOINT ["/opt/cpm/bin/uid_daemon.sh"]

USER 2

CMD ["/opt/cpm/bin/start.sh"]
