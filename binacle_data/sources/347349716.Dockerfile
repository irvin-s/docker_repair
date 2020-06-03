FROM ubuntu:14.04
ENV dub_filename dub-0.9.23-linux-x86_64.tar.gz
ENV dub_url http://code.dlang.org/files/$dub_filename

ENV dmd_filename dmd_2.067.0-0_amd64.deb
ENV dmd_url http://downloads.dlang.org/releases/2.x/2.067.0/$dmd_filename

WORKDIR /
RUN apt-get update
RUN apt-get -y install wget build-essential gawk m4 gcc-multilib libcurl3 xdg-utils git
RUN uname -a
RUN wget $dub_url
RUN wget $dmd_url
RUN dpkg -i $dmd_filename

RUN tar xzvf $dub_filename
RUN cp dub /usr/bin/dub

