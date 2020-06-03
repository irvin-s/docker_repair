# Runtime environment for Perl-related stuff @ WCar

FROM oddlid/lobsterperl
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN apt-get -qq update \
		&& \
		apt-get -y --no-install-recommends install \
		libexpat1-dev \
		libncurses5-dev \
		libreadline6-dev \
		libxml2-dev \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN cpanm Term::Size
RUN cpanm --force Term::ReadKey
RUN cpanm JMX::Jmx4Perl
