# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://stackoverflow.com/questions/40234847/docker-timezone-in-ubuntu-16-04-image
RUN apt-get update && apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


RUN mkdir -p /etc/my_init.d
COPY logtime.sh /etc/my_init.d/logtime.sh
RUN chmod +x /etc/my_init.d/logtime.sh

RUN apt-get install -y libev-perl libanyevent-perl libjson-xs-perl unzip git make cmake cpanminus libdata-printer-perl
RUN apt-get install -y libr3-dev

RUN cpanm -vn Digest::SHA1
RUN cpanm -vn Time::Moment
RUN cpanm -vn URI::XSEscape
RUN cpanm -vn Router::R3

RUN mkdir -p /tmp/unpacked

RUN cd /usr/src && git clone https://github.com/Mons/AnyEvent-HTTP-Server-II.git && cd AnyEvent-HTTP-Server-II && perl Makefile.PL && make install

RUN cd /usr/src && git clone https://github.com/Mons/HTTP-Easy.git && cd HTTP-Easy && perl Makefile.PL && make install

COPY server.pl /etc/my_init.d/99-hlcupserver
RUN chmod +x /etc/my_init.d/99-hlcupserver

RUN perl -c /etc/my_init.d/99-hlcupserver

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
