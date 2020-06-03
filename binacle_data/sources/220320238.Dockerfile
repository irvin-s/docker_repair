FROM centos:7

RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN yum install -q -y epel-release
RUN yum install -q -y perl perl-App-cpanminus perl-Test-Simple git make cmake gcc gcc-c++ pcre-devel automake libtool check

RUN cd /usr/src && git clone https://github.com/c9s/r3 && cd r3 && perl -i -lpe 's{\Q[have_check="no"]\E}{}' configure.ac && ./autogen.sh && ./configure && make install

RUN yum install -q -y unzip perl-JSON-XS perl-AnyEvent perl-Time-Moment perl-Digest-SHA1
RUN yum install -q -y perl-Clone-PP perl-File-HomeDir perl-File-Which perl-Package-Stash perl-Dist-CheckConflicts perl-Module-Runtime perl-Package-Stash-XS perl-Module-Implementation perl-Sort-Naturally
RUN cpanm -n EV URI::XSEscape Router::R3 DDP

RUN mkdir -p /tmp/unpacked

# RUN cd /usr/src && git clone https://github.com/Mons/AnyEvent-HTTP-Server-II.git && cd AnyEvent-HTTP-Server-II && perl Makefile.PL && make install
# RUN cd /usr/src && git clone https://github.com/Mons/HTTP-Easy.git && cd HTTP-Easy && perl Makefile.PL && make install
# RUN cd /usr/src && git clone https://github.com/Mons/Daemond-Lite.git && cd Daemond-Lite && perl Makefile.PL && make install

RUN rm -rf /usr/src/*
RUN yum erase -q -y make git cmake gcc automake libtool check gcc-c++ perl-App-cpanminus perl-Test-Simple
RUN package-cleanup --quiet --leaves | xargs yum remove -y

COPY daemon.pl /opt/daemon
RUN chmod +x /opt/daemon
RUN perl -c /opt/daemon

CMD "/opt/daemon"

EXPOSE 80
