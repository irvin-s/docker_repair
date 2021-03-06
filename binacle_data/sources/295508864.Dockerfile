FROM centos:7

LABEL Vendor="Crunchy Data Solutions" \
	PostgresVersion="11" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="4.0.0" \
	summary="Crunchy Data PostgreSQL Operator - Apiserver" \
	description="Crunchy Data PostgreSQL Operator - Apiserver"

ENV PGVERSION="11" PGDG_REPO="pgdg-redhat-repo-latest.noarch.rpm" PGDG_REPO_DISABLE="pgdg10,pgdg96,pgdg95,pgdg94" \
    BACKREST_VERSION="2.13"

# PGDG PostgreSQL Repository

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/${PGVERSION}/redhat/rhel-7-x86_64/${PGDG_REPO}

RUN yum -y update && \
#yum -y install epel-release && \
yum -y install --disablerepo="${PGDG_REPO_DISABLE}" \
    psmisc openssh-server openssh-clients pgbackrest-"${BACKREST_VERSION}" hostname pgocps-ng && \
yum -y clean all

RUN groupadd pgbackrest -g 2000 && useradd pgbackrest -u 2000 -g 2000
ADD bin/pgo-backrest-repo/pgo-backrest-repo.sh /usr/local/bin
RUN chmod +x /usr/local/bin/pgo-backrest-repo.sh && mkdir -p /opt/cpm/bin && chown -R pgbackrest:pgbackrest /opt/cpm

ADD bin/uid_pgbackrest.sh /opt/cpm/bin

ADD conf/pgo-backrest-repo/.bashrc /home/pgbackrest

RUN chmod g=u /etc/passwd && \
        chmod g=u /etc/group

RUN mkdir /.ssh && chown pgbackrest:pgbackrest /.ssh && chmod o+rwx /.ssh

USER pgbackrest

ENTRYPOINT ["/opt/cpm/bin/uid_pgbackrest.sh"]

VOLUME ["/sshd", "/backrestrepo" ]

CMD ["pgo-backrest-repo.sh"]
