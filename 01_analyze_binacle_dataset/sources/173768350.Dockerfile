FROM centos:centos7
MAINTAINER John E. Vincent

VOLUME /pkg

RUN rpm -ivh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm && rpm --import http://mirror.pnl.gov/epel/RPM-GPG-KEY-EPEL-7 && yum makecache
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN yum install -y \
    flex \
    autoconf \
    make \
    bison \
    gcc \
    gcc-c++ \
    kernel-devel \
    m4 \
    patch \
    git \
    openssl-devel \
    expat-devel \
    perl-ExtUtils-MakeMaker \
    curl-devel \
    tar \
    unzip \
    libxml2-devel \
    libxslt-devel.x86_64 \
    rpm-build \
    redhat-rpm-config \
    rsync \
    ncurses-devel \
    zlib-devel \
    fakeroot

RUN yum clean all
   
RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN git config --global user.email "packager@myco" && \
    git config --global user.name "Omnibus Packager"

RUN echo "export PATH=\${PATH}:/opt/chef/embedded/bin" | tee -a /etc/profile.d/chef-ruby.sh

RUN source /etc/profile.d/chef-ruby.sh && gem install bundler --no-ri --no-rdoc
