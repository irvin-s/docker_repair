# "lobsterperl" - My anything-perl image for development/testing
FROM oddlid/debian-base:stretch
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV PERL_CPANM_OPT --mirror http://ftp.acc.umu.se/mirror/CPAN/

RUN apt-get -qq update \
		&& \
		apt-get -y --no-install-recommends install \
		cpanminus \
		libcrypt-ssleay-perl \
		libnet-ssleay-perl \		
		libssl-dev \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN cpanm \
		DateTime \
		EV \
		IO::Socket::IP \
		IO::Socket::Socks \
		IO::Socket::SSL \
		Mojolicious

CMD ["bash"]
