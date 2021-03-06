FROM centos:7

RUN yum install -y initscripts glibc.i686

ARG apm_server_pkg
COPY $apm_server_pkg $apm_server_pkg
RUN rpm -ivh $apm_server_pkg

COPY test.sh test.sh

CMD ./test.sh
