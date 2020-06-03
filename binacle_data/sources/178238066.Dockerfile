# An attempt at containerizing op5 Monitor
# Odd, 2014-11-03 14:05:59

FROM centos:centos6
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV OP5_VERSION 6.3.2

## Stuff that's needed for plugins etc

RUN yum install -y \
		epel-release \
		&& \
		yum install -y \
		automake \
		curl \
		expat-devel \
		gcc \
		gcc-c++ \
		kernel-devel \
		libvirt \
		libxml2-devel \
		make \
		mysql-devel \
		ncurses-devel \
		perl-Crypt-SSLeay \
		perl-ExtUtils-MakeMaker \
		perl-Net-SSLeay \
		perl-TermReadKey \
		perl-WWW-Curl \
		readline-devel \
		supervisor \
		tar \
		uuid-perl \
		which \
		wget \
		yum-plugin-versionlock

ADD op5-monitor-${OP5_VERSION}-20140827_rh-rpms-only.tar.gz /root/
ADD mods/install_${OP5_VERSION}.py /root/op5-monitor-${OP5_VERSION}/
WORKDIR /root/op5-monitor-${OP5_VERSION}
RUN rpm -Uvh ./rpm/centos/6/x86_64/nrpe-2.13.3-op5.1.x86_64.rpm
RUN yum versionlock add nrpe
RUN ./install_${OP5_VERSION}.py --noninteractive

RUN chown -R monitor:apache /etc/op5 /opt/monitor/op5/merlin /opt/monitor/etc /opt/plugins/custom /usr/lib64/merlin/mon/modules
RUN [[ -d /var/cache/merlin ]] || mkdir -p /var/cache/merlin && chown -R monitor:apache /var/cache/merlin
RUN [[ -d /var/run/op5 ]] || mkdir -p /var/run/op5 && chown -R monitor:apache /var/run/op5

RUN wget -O - https://cpanmin.us | perl - App::cpanminus
#ENV CPAN_MIRROR http://ftp.acc.umu.se/mirror/CPAN/
ENV CPAN_MIRROR http://www.cpan.dk/

RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} Digest::SHA
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} IO::Socket::SSL
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} --notest Linux::Inotify2
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} --notest Term::ReadLine::Perl
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} --notest Term::ReadLine::Gnu
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} Module::CoreList
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} JMX::Jmx4Perl
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} AnyEvent
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} EV
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} Mojolicious
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} Parallel::ForkManager
RUN /usr/local/bin/cpanm --mirror ${CPAN_MIRROR} YAML

# Term-ReadLine-Perl-1.0303 - enter perl expr: exit - stops there and waits for input. Could be why auto build fails


# Make adjustments for the way we run op5 @ WirelessCar
# ADD mods/wcar_mods.sh /opt/monitor/
# RUN /opt/monitor/wcar_mods.sh

# Making volumes of all dirs what are written to and/or contains config
# /opt/monitor/etc
# /opt/monitor/op5/merlin/logs
# /opt/monitor/op5/merlin/binlogs
# /opt/monitor/op5/merlin/merlin.conf
# /opt/monitor/op5/merlin/ipc.sock

# /var/cache/merlin
# /var/run/op5
# /var/run
# /var/log
# /var/lib/mysql
# /etc/op5

WORKDIR /opt/monitor
