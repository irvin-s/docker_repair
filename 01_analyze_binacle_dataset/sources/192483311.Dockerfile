FROM debian:stretch

RUN  dpkg --add-architecture i386  && \
    apt-get update && \
    apt-get install  -y  build-essential \
    cpio \
    libc6:i386 \
    libstdc++6:i386 \
    libxml2-dev \
    libssl1.0-dev \
    zlib1g-dev 

WORKDIR "/xarsrc"
ADD installers/xar/xar-1.5.2.tar.gz .
WORKDIR "/xarsrc/xar-1.5.2"
RUN CFLAGS=-w CPPFLAGS=-w CXXFLAGS=-w LDFLAGS=-w ./configure && make && make install

