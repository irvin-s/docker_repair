FROM centos:7

LABEL name="crunchydata/pgpool" \
	vendor="crunchy data" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="2.4.0" \
        url="https://crunchydata.com" \
        summary="Contains the pgpool utility as a PostgreSQL-aware load balancer" \
        description="Offers a smart load balancer in front of a Postgres cluster, sending writes only to the primary and reads to the replica(s). This allows an application to only have a single connection point when interacting with a Postgres cluster." \
        io.k8s.description="pgpool container" \
        io.k8s.display-name="Crunchy pgpool container" \
        io.openshift.expose-services="" \
        io.openshift.tags="crunchy,database"

ENV PGVERSION="11" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm"

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install \
      gettext \
      hostname \
      procps-ng \
 && yum -y install \
      postgresql11 \
      pgpool-II-11 \
      pgpool-II-11-extensions \
 && yum -y clean all

RUN mkdir -p /opt/cpm/bin /opt/cpm/conf

ADD bin/pgpool /opt/cpm/bin
ADD bin/common /opt/cpm/bin
ADD conf/pgpool /opt/cpm/conf

RUN ln -sf /opt/cpm/conf/pool_hba.conf /etc/pgpool-II-11/pool_hba.conf \
  && ln -sf /opt/cpm/conf/pgpool/pool_passwd /etc/pgpool-II-11/pool_passwd

RUN chgrp -R 0 /opt/cpm && \
    chmod -R g=u /opt/cpm


# open up the postgres port
EXPOSE 5432

# add volumes to allow override of pgpool config files
VOLUME ["/pgconf"]

RUN chmod g=u /etc/passwd
ENTRYPOINT ["opt/cpm/bin/uid_daemon.sh"]

USER 2

CMD ["/opt/cpm/bin/startpgpool.sh"]
