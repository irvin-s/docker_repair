# Docker container for Ubuntu 12.04

# See https://github.com/ceejatec/naked-docker/ for details about the
# construction of the base image.

FROM ceejatec/naked-ubuntu:12.04
MAINTAINER ceej@couchbase.com

USER root

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -f /var/cache/apt/archives/*.deb && \
    mkdir /var/run/sshd

# Create buildbot user with password-less sudo privs, and give 
# ownership of /opt/couchbase
RUN useradd buildbot -G sudo -m -s /bin/bash && \
    mkdir -p /opt/couchbase && chown -R buildbot:buildbot /opt/couchbase && \
    echo 'buildbot:buildbot' | chpasswd && \
    sed -ri 's/ALL\) ALL/ALL) NOPASSWD:ALL/' /etc/sudoers
ADD .ssh /home/buildbot/.ssh
RUN chown -R buildbot:buildbot /home/buildbot/.ssh && chmod 700 /home/buildbot/.ssh

# Expose and start SSH daemon
EXPOSE 22
CMD [ "/usr/sbin/sshd", "-D" ]

# Install Couchbase build dependencies
RUN apt-get install -y g++ git-core tar libssl-dev rubygems rake ncurses-dev python-dev devscripts debhelper ed man curl libc6-i386 && \
    rm -f /var/cache/apt/archives/*.deb
RUN echo 'PATH="/usr/lib/ccache:$PATH"' >> /home/buildbot/.profile
RUN mkdir /tmp/deploy && \
    curl http://www.cmake.org/files/v2.8/cmake-2.8.12.2-Linux-i386.sh -o /tmp/deploy/cmake.sh && \
    (echo y ; echo n) | sh /tmp/deploy/cmake.sh --prefix=/usr/local && \
    cd /tmp && rm -rf /tmp/deploy

# Install third-party build dependencies. Note: python-software-properties
# is only required for add-apt-repository; add-apt-repository is only
# required to get python2.6; and python2.6 is only required for gyp, which
# is part of the v8 build. python2.6 is also required for our compiling of
# pysqlite and pysnappy, and for that we even need python2.6-dev.
RUN apt-get install -y python-software-properties && \
    add-apt-repository ppa:fkrull/deadsnakes && \
    apt-get update && \
    apt-get install -y m4 python2.6 python2.6-dev && \
    rm -f /var/cache/apt/archives/*.deb
RUN mkdir /tmp/deploy && \
    curl -L http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz -o /tmp/deploy/autoconf-2.69.tar.gz && \
    cd /tmp/deploy && tar -xzf autoconf-2.69.tar.gz && \
    cd autoconf-2.69 && ./configure --prefix=/usr/local && make && make install && \
    curl -L http://ftpmirror.gnu.org/automake/automake-1.11.1.tar.gz -o /tmp/deploy/automake-1.11.1.tar.gz && \
    cd /tmp/deploy && tar -xzf automake-1.11.1.tar.gz && \
    cd automake-1.11.1 && ./configure --prefix=/usr/local && make && make install && \
    curl -L http://ftpmirror.gnu.org/libtool/libtool-2.4.2.tar.gz -o /tmp/deploy/libtool-2.4.2.tar.gz && \
    cd /tmp/deploy && tar -xzf libtool-2.4.2.tar.gz && \
    cd libtool-2.4.2 && ./configure --prefix=/usr/local && make && make install && \
    cd /tmp && rm -rf /tmp/deploy

# Install requirements for buildbot and buildbot tasks
RUN apt-get install -y python-setuptools python-dateutil libxml-simple-perl libwww-perl && \
    rm -f /var/cache/apt/archives/*.deb && \
    easy_install buildbot_slave && \
    mkdir /home/buildbot/buildbot_slave && \
    buildslave create-slave /home/buildbot/buildbot_slave 10.1.1.210:9999 ubuntu-1204-builddocker-01 ubuntu-1204-builddocker-01 && \
    echo "Couchbase Build Team <build-team@couchbase.com>" > /home/buildbot/buildbot_slave/info/admin && \
    echo "Ubuntu 12.04 x86_64 Couchbase Build Slave running in Docker" > /home/buildbot/buildbot_slave/info/host && \
    chown -R buildbot:buildbot /home/buildbot/buildbot_slave
RUN mkdir /tmp/deploy && \
    curl -L 'http://downloads.sourceforge.net/project/s3tools/s3cmd/1.5.0-rc1/s3cmd-1.5.0-rc1.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fs3tools%2Ffiles%2Fs3cmd%2F1.5.0-rc1%2F&ts=1406252479&use_mirror=superb-dca2' -o /tmp/deploy/s3cmd.tar.gz && \
    cd /tmp/deploy && tar -xvf s3cmd.tar.gz && cd s3cmd-1.5.0-rc1 && \
    python setup.py build && python setup.py install && \
    cd /tmp && rm -rf /tmp/deploy
ADD .s3cfg /home/buildbot/.s3cfg
RUN chown buildbot:buildbot /home/buildbot/.s3cfg

# Override default command for buildbot purposes
CMD su - buildbot -c "buildslave start /home/buildbot/buildbot_slave"; /usr/sbin/sshd -D
