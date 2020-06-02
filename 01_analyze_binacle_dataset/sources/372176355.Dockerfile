FROM centos:6

RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install \
        autoconf \
        automake \
        bison \
        expect \
        flex \
        gcc \
        git \
        java-devel \
        java-1.6.0-openjdk-devel \
        libcurl-devel \
        libgcrypt-devel \
        libtool \
        libtool-ltdl-devel \
        make \
        mysql-devel \
        openssl-devel \
        perl-devel \
        perl-ExtUtils-Embed \
        postgresql-devel \
        python-devel \
        rpm-build \
        varnish-libs-devel \
        which \
        yajl-devel \
 && yum -y clean all
