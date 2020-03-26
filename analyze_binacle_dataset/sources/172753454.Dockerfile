FROM greyltc/archlinux:2016-10-23

RUN pacman -Syu --noconfirm virtualbox unzip

ADD https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip /tmp/packer.zip
RUN unzip -d /usr/local/bin /tmp/packer.zip && rm /tmp/packer.zip
