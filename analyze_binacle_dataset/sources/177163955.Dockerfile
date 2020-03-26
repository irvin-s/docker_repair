FROM ubuntu:14.04
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# setup our Ubuntu sources (ADD breaks caching)
RUN echo "deb http://tw.archive.ubuntu.com/ubuntu/ trusty main\n\
deb http://tw.archive.ubuntu.com/ubuntu/ trusty multiverse\n\
deb http://tw.archive.ubuntu.com/ubuntu/ trusty universe\n\
deb http://tw.archive.ubuntu.com/ubuntu/ trusty restricted\n\
deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main\n\
"> /etc/apt/sources.list

# no Upstart or DBus
# https://github.com/dotcloud/docker/issues/1724#issuecomment-26294856
RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server pwgen sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        nodejs \
        libreoffice firefox \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD noVNC /noVNC/

ADD startup.sh /
ADD supervisord.conf /
EXPOSE 6080
EXPOSE 5900
EXPOSE 22
WORKDIR /

# Remove LibOffice
RUN apt-get remove -y --purge libreoffice* libexttextcat-data* && sudo apt-get -y autoremove

# Install wget
RUN apt-get update -y && \
    apt-get install -y wget

# Install OpenOffice
RUN wget http://sourceforge.net/projects/openofficeorg.mirror/files/4.0.0/binaries/en-US/Apache_OpenOffice_4.0.0_Linux_x86-64_install-deb_en-US.tar.gz
RUN tar -xvf Apache_OpenOffice*.tar.gz
RUN dpkg -i en-US/DEBS/*.deb
RUN dpkg -i en-US/DEBS/desktop-integration/*.deb

ENTRYPOINT ["/startup.sh"]
