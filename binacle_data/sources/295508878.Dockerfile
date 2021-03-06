FROM centos:7

LABEL  Vendor="Crunchy Data Solutions" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="4.0.0" \
	summary="Crunchy Data PostgreSQL Operator" \
	description="Crunchy Data PostgreSQL Operator"

ENV PGVERSION="11" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm"

# PGDG PostgreSQL Repository

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update && yum -y install hostname postgresql11  && yum -y clean all

ADD bin/postgres-operator /usr/local/bin
ADD conf/postgres-operator /default-pgo-config

USER daemon

ENTRYPOINT ["postgres-operator"]
