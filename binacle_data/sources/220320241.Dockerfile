FROM gentoo/stage3-amd64-nomultilib

COPY portage-latest.tar.bz2 /tmp/
RUN mkdir -p /usr && \
	bzcat /tmp/portage-latest.tar.bz2 | tar -xf - -C /usr && \
	mkdir -p /usr/portage/distfiles /usr/portage/metadata /usr/portage/packages && \
	rm /tmp/portage-latest.tar.bz2

RUN eselect locale set C

# Tume make.conf
RUN perl -i -lpe 's{^CFLAGS=.+}{CFLAGS="-O2 -march=sandybridge -faggressive-loop-optimizations -fomit-frame-pointer -pipe"}' /etc/portage/make.conf
RUN perl -i -lpe 's{^USE=.+}{USE="bindist -nls -python -threads -webdav -gpg"}' /etc/portage/make.conf
RUN echo -ne "ACCEPT_KEYWORDS=~amd64\n" >> /etc/portage/make.conf

# Rebuild core libs for -march
# RUN emerge -1 sys-libs/glibc dev-libs/libpcre

# RUN emerge dev-perl/App-cpanminus dev-vcs/git ragel

# Need get & ragel
RUN emerge dev-vcs/git ragel

# Build stableperl
COPY stableperl-5.22.0-1.001.tar.gz /usr/src
RUN cd /usr/src && tar zxf stableperl-5.22.0-1.001.tar.gz && \
	cd stableperl-5.22.0-1.001 && \
	./Configure -des -Doptimize="-fomit-frame-pointer -pipe -O2 -march=sandybridge -faggressive-loop-optimizations" -Duse64bitint -DUSEMYMALLOC -Dprefix=/usr/local -Uusethreads -Uuseithreads && \
	make install

# Build r3
RUN cd /usr/src && git clone https://github.com/c9s/r3 && cd r3 && perl -i -lpe 's{\Q[have_check="no"]\E}{}' configure.ac && ./autogen.sh && ./configure && make install
RUN echo -ne "PORTDIR_OVERLAY=/var/lib/layman/perl-experimental\n" >> /etc/portage/make.conf

# RUN mkdir -p /var/lib/layman && cd /var/lib/layman  && /usr/bin/git clone https://anongit.gentoo.org/git/proj/perl-overlay.git /var/lib/layman/perl-experimental
# RUN echo -ne "=dev-perl/Time-Moment-0.420.0 ~amd64\n" >> /etc/portage/package.accept_keywords
# RUN emerge JSON-XS AnyEvent Time-Moment Digest-SHA1 dev-perl/EV dev-perl/Data-Printer

RUN emerge libstdc++

RUN wget -O - https://cpanmin.us | /usr/local/bin/perl - App::cpanminus
# Install deps
RUN /usr/local/bin/cpanm -n JSON::XS EV AnyEvent Digest::SHA1 Time::Moment DDP && rm -rf /root/.cpanm

COPY Local-HLCup-0.01.tar.gz /tmp
COPY Local-HTTPServer-0.01.tar.gz /tmp
RUN /usr/local/bin/cpanm -nv /tmp/Local-HLCup-0.01.tar.gz /tmp/Local-HTTPServer-0.01.tar.gz && rm -rf /root/.cpanm

# Clean all deps leftovers
RUN emerge -C dev-vcs/git ragel && emerge --depclean
RUN rm -rf /usr/portage /usr/src

# Prepare env

RUN mkdir -p /tmp/unpacked

COPY daemon.pl /opt/daemon
RUN chmod +x /opt/daemon
RUN /usr/local/bin/perl -c /opt/daemon

CMD ["/usr/local/bin/perl","/opt/daemon"]


EXPOSE 80
