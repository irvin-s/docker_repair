FROM ubuntu:18.04

RUN apt update

RUN apt install -y -qq apt-utils

# boost
RUN apt install -y -qq libboost-filesystem1.65-dev libboost-filesystem1.65.1 libboost-iostreams1.65-dev libboost-iostreams1.65.1 libboost-locale1.65-dev libboost-locale1.65.1 libboost-regex1.65-dev libboost-regex1.65.1 libboost-serialization1.65-dev libboost-serialization1.65.1 libasio-dev libboost-program-options1.65-dev libboost-program-options1.65.1 libboost-random1.65-dev libboost-random1.65.1 libboost-system1.65-dev libboost-system1.65.1 libboost-thread1.65-dev libboost-thread1.65.1 libboost-test-dev

# SDL
RUN apt install -y -qq libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev

# make tzdata not prompt for a timezone
ENV DEBIAN_FRONTEND=noninteractive

# misc
RUN apt install -y -qq libpng16-16 libpng-dev libreadline6-dev libvorbis-dev libcairo2 libcairo2-dev libpango-1.0-0 libpango1.0-dev libfribidi0 libfribidi-dev libbz2-1.0 libbz2-dev zlib1g zlib1g-dev libpangocairo-1.0-0 libssl-dev libmysqlclient-dev expect-dev

# programs
RUN apt install -y -qq openssl gdb xvfb bzip2 git scons cmake make ccache gcc g++ clang lld

WORKDIR /home/wesnoth-travis
