FROM registry.access.redhat.com/rhel7

LABEL Vendor="Crunchy Data Solutions" \
	PostgresVersion="11" \
	name="pgo-backrest-repo" \
	PostgresFullVersion="11.3" \
	Version="7.6" \
	Release="4.0.0" \
        run='docker run -d -p 8080:80 --name=web-app web-app' \
	summary="Crunchy Data PostgreSQL Operator - pgo-backrest-repo" \
	description="Crunchy Data PostgreSQL Operator - pgo-backrest-repo"

ENV PGVERSION="11" BACKREST_VERSION="2.13"

COPY redhat/atomic/pgo_backrest_repo/help.1 /help.1
COPY redhat/atomic/pgo_backrest_repo/help.md /help.md
COPY redhat/licenses /licenses

ADD conf/RPM-GPG-KEY-crunchydata  /
ADD conf/crunchypg11.repo /etc/yum.repos.d/
RUN rpm --import RPM-GPG-KEY-crunchydata

RUN yum -y --enablerepo=rhel-7-server-ose-3.11-rpms --disablerepo=crunchy* update && \
yum -y install psmisc openssh-server openssh-clients crunchy-backrest-"${BACKREST_VERSION}" hostname pgocps-ng && \
yum -y clean all

RUN groupadd pgbackrest -g 2000 && useradd pgbackrest -u 2000 -g 2000
ADD bin/pgo-backrest-repo/pgo-backrest-repo.sh /usr/local/bin
RUN chmod +x /usr/local/bin/pgo-backrest-repo.sh && mkdir -p /opt/cpm/bin && chown -R pgbackrest:pgbackrest /opt/cpm

ADD bin/uid_pgbackrest.sh /opt/cpm/bin

ADD conf/pgo-backrest-repo/.bashrc /

RUN chmod g=u /etc/passwd && \
        chmod g=u /etc/group

#RUN mkdir /tmp/.ssh && ln -s /tmp/.ssh /.ssh && chown 26:26 /tmp/.ssh /.ssh
#RUN ln -s /sshd /.ssh && chown 26:26 /.ssh && chmod 400 /.ssh/
RUN mkdir /.ssh && chown pgbackrest:pgbackrest /.ssh && chmod o+rwx /.ssh

USER pgbackrest

ENTRYPOINT ["/opt/cpm/bin/uid_pgbackrest.sh"]
VOLUME ["/sshd", "/backrestrepo" ]

CMD ["pgo-backrest-repo.sh"]
