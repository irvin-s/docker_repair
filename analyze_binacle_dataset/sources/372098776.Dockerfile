# container for a fast testing SPEC file
# user and dirs according to Copr Build Service
FROM centos:centos7
ENV LANG=en_US.utf8
RUN yum install gcc make rpm-build -y
RUN useradd -ms /bin/bash worker
RUN mkdir /builddir/ && chown worker: /builddir
USER worker
RUN mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY zbx_sockstat.c Makefile /home/worker/rpmbuild/SOURCES/
COPY RPM/zabbix-agent-sockstat.spec /home/worker/rpmbuild/SPECS/
RUN rpmbuild --undefine=_disable_source_fetch  -ba home/worker/rpmbuild/SPECS/zabbix-agent-sockstat.spec
CMD /bin/bash
