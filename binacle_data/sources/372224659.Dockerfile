FROM ubuntu:trusty

RUN apt-get -qq update
RUN apt-get install -y -qq autopoint automake autoconf intltool libc6-dev-i386 libc6-dev yasm perl wget g++-multilib zip bzip2 git mercurial subversion make libtool pkg-config libglib2.0-bin
