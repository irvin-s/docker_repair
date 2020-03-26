FROM centos:7

RUN yum groupinstall -y "Development Tools" && \
    yum install -y sqlite-devel \
               gdbm-devel \
               openssl-devel \
               ncurses-devel \
               readline-devel \
               bzip2-devel \
               db4-devel \
               tk-devel \
               libdb-devel