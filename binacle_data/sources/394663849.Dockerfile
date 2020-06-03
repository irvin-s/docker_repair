FROM centos:centos7

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN useradd --system --home-dir / scm
RUN useradd --system --home-dir / phd

COPY mercurial.repo /etc/yum.repos.d/mercurial.repo

RUN yum install -y epel-release
RUN yum install -y \
    git            \
    mercurial      \
    php-cli        \
    php-curl       \
    php-devel      \
    php-gd         \
    php-json       \
    php-ldap       \
    php-mbstring   \
    php-mysql      \
    php-opcache    \
    php-process    \
    sudo           \
    supervisor     \
    which

COPY rebase.rc /etc/mercurial/hgrc.d/rebase.rc
COPY scm-sudo /etc/sudoers.d/scm-sudo

ENV PHABRICATOR_VERSION=stable \
    LIBPHUTIL_VERSION=stable   \
    ARCANIST_VERSION=stable

RUN cd /opt && \
    git clone --branch $PHABRICATOR_VERSION https://secure.phabricator.com/diffusion/P/phabricator.git && \
    git clone --branch $LIBPHUTIL_VERSION https://secure.phabricator.com/diffusion/PHU/libphutil.git && \
    git clone --branch $ARCANIST_VERSION https://secure.phabricator.com/diffusion/ARC/arcanist.git
