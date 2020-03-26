FROM ubuntu:18.04
MAINTAINER slipper "slipper@0ops.net"

RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/' /etc/apt/sources.list
RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y build-essential libtool g++ gcc \
    texinfo curl wget automake autoconf python python-dev git subversion \
    unzip libc6-dbg libc6-dbg:i386
RUN apt-get install -y vim tmux zsh python-pip qemu gdb man ltrace strace

WORKDIR /root/tools/
COPY .git .git
RUN git checkout .
RUN ./install pip oh-my-zsh vundle ipython pwntools pwndbg xrop

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8' TERM='xterm-256color'
WORKDIR /root/
ENTRYPOINT ["/bin/zsh"]
