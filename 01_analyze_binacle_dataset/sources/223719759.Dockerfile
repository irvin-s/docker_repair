FROM centos:centos7

# Allow scripts to detect we're running in our own container
RUN touch /addons-server-centos7-container

# Set the locale. This is mainly so that tests can write non-ascii files to
# disk.
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ADD docker/RPM-GPG-KEY-mysql /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
ADD docker/RPM-GPG-KEY-hadjango /etc/pki/rpm-gpg/RPM-GPG-KEY-hadjango
ADD docker/RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

ADD docker/epel.repo /etc/yum.repos.d/epel.repo
ADD docker/epel-testing.repo /etc/yum.repos.d/epel-testing.repo
ADD docker/hadjango.repo /etc/yum.repos.d/hadjango.repo

# For mysql-python dependencies
ADD docker/mysql.repo /etc/yum.repos.d/mysql.repo

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-hadjango \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 \
    && yum update -y \
    && yum install -y \
        # Supervisor is being used to start and keep our services running
        supervisor \
        # General (dev-) dependencies
        bash-completion \
        gcc-c++ \
        curl \
        make \
        libjpeg-devel \
        cyrus-sasl-devel \
        libxml2-devel \
        libxslt-devel \
        zlib-devel \
        libffi-devel \
        openssl-devel \
        python-devel \
        # Git, because we're using git-checkout dependencies
        git \
        # Nodejs for less, stylus, uglifyjs and others
        nodejs \
        # Dependencies for mysql-python
        mysql-community-devel \
        mysql-community-client \
        mysql-community-libs \
        epel-release \
        swig \
        python-uwsgidecorators \
        uwsgi-devel \
        uwsgi-logger-file \
        uwsgi-plugin-python \
        uwsgi-plugin-zergpool \
        uwsgi-router-http \
        uwsgi-router-raw \
        uwsgi-router-uwsgi \
        uwsgi-stats-pusher-file \
        uwsgi-stats-pusher-socket \
        uwsgi-plugin-cheaper-busyness \
        python-pip \
        python-setuptools \
        python-virtualenv \
    && yum clean all

RUN pip install wheel pyOpenSSL ndg-httpsclient pyasn1 certifi urllib3 psutil supervisor fabric \
    && rm -rf /root/.cache

COPY . /code
WORKDIR /code

ENV SWIG_FEATURES="-D__x86_64__"

# Preserve bash history across image updates.
# This works best when you link your local source code
# as a volume.
ENV HISTFILE /code/docker/artifacts/bash_history

# Configure bash history.
ENV HISTSIZE 50000
ENV HISTIGNORE ls:exit:"cd .."

# This prevents dupes but only in memory for the current session.
ENV HISTCONTROL erasedups
