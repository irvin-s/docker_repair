FROM centos:6
ENV dub_filename dub-0.9.23-1.x86_64.rpm
ENV dub_url http://code.dlang.org/files/$dub_filename

ENV dmd_filename dmd-2.067.1-0.fedora.x86_64.rpm
ENV dmd_url http://downloads.dlang.org/releases/2.x/2.067.1/$dmd_filename

WORKDIR /
RUN yum -y install gcc glibc-devel make ncurses-devel openssl-devel autoconf git wget

RUN wget $dub_url
RUN wget $dmd_url

RUN yum -y install $dmd_filename
RUN yum -y install $dub_filename


