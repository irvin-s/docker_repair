FROM centos:6
MAINTAINER Chad Barraford <chad@rstudio.com>

# EPEL
RUN     rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# RPMForge
RUN     rpm -Uvh http://mirror.chpc.utah.edu/pub/repoforge/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

# SSH
EXPOSE 22
RUN yum -y groupinstall "Development tools"
RUN yum -y install rsyslog screen passwd java-1.7.0-openjdk sudo wget git python26 tar python-devel mercurial gcc glibc-devel xorg-x11-server-Xvfb firefox pam-devel


# There's a networking bug with some versions of git which sometimes causes
# 'go get' to hang; force a git update.
#
# http://stackoverflow.com/questions/21820715/how-to-install-latest-version-of-git-on-centos-6-x
# https://groups.google.com/forum/#!topic/golang-nuts/RKz9ASmJm3o
RUN yum -y --disablerepo=base,updates --enablerepo=rpmforge-extras update git

RUN yum install -y python-setuptools python-unittest2
RUN yum install -y R curl libcurl-devel

# install cmake
RUN curl -Lk http://www.cmake.org/files/v2.8/cmake-2.8.10.tar.gz | tar xz
RUN cd cmake-2.8.10 && ./configure && make && make install

RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum -y install devtoolset-2-gcc devtoolset-2-binutils
RUN yum -y install devtoolset-2-gcc-gfortran devtoolset-2-gcc-c++

# create jenkins user, make sudo. try to keep this toward the bottom for less cache busting
ARG JENKINS_GID=999
ARG JENKINS_UID=999
RUN groupadd -g $JENKINS_GID jenkins && \
    useradd -m -d /var/lib/jenkins -u $JENKINS_UID -g jenkins jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
