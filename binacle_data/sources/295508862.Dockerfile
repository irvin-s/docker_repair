FROM centos:7

LABEL Vendor="Crunchy Data Solutions" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="4.0.0" \
	summary="Crunchy Data PostgreSQL Operator - Apiserver" \
	description="Crunchy Data PostgreSQL Operator - Apiserver"

ENV PGVERSION="11" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm"

# PGDG PostgreSQL Repository

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update && yum -y install postgresql11 hostname && yum -y clean all

ADD bin/apiserver /usr/local/bin
ADD bin/postgres-operator/runpsql.sh /usr/local/bin
ADD conf/postgres-operator /default-pgo-config

USER daemon

ENTRYPOINT ["/usr/local/bin/apiserver"]
