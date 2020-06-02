#
# Dockerized zcash cpuminer 
# usage: docker run marsmensch/zcash-cpuminer -l zec.suprnova.cc:2142 -u mnschx.donate -p x 
#
# BTC tips welcome 1PboFDkBsW2i968UnehWwcSrM9Djq5LcLB
#
#▒███████▒ ▄████▄   ▄▄▄        ██████  ██░ ██ 
#▒ ▒ ▒ ▄▀░▒██▀ ▀█  ▒████▄    ▒██    ▒ ▓██░ ██▒
#░ ▒ ▄▀▒░ ▒▓█    ▄ ▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░
#  ▄▀▒   ░▒▓▓▄ ▄██▒░██▄▄▄▄██   ▒   ██▒░▓█ ░██ 
#▒███████▒▒ ▓███▀ ░ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓
#░▒▒ ▓░▒░▒░ ░▒ ▒  ░ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒
#░░▒ ▒ ░ ▒  ░  ▒     ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░
#░ ░ ░ ░ ░░          ░   ▒   ░  ░  ░   ░  ░░ ░
#  ░ ░    ░ ░            ░  ░      ░   ░  ░  ░
#░        ░   
#
# If you want to mine within an interactive shell:
# 1) start the container
# docker run --interactive --tty --entrypoint=/bin/bash marsmensch/zcash-cpuminer
#
# 2) run the cpuminer manually daemon 
# nheqminer -l zec.suprnova.cc:2142 -u mnschx.donate -p x -t 4 
#
# 3) happyness
#
# Last change:
# * Allow any Stratum based pool, add suprnova default (6086f95) 

FROM                 ubuntu:16.04
MAINTAINER           Florian Maier <contact@marsmenschen.com>
ENV GIT_PROJECT      nheqminer
#ENV GIT_URL          git://github.com/ocminer/${GIT_PROJECT}.git
ENV GIT_URL          git://github.com/sarath-hotspot/${GIT_PROJECT}.git
ENV REFRESHED_AT     2016-10-30

# install dependencies
RUN apt-get autoclean && apt-get autoremove && apt-get update && \
    apt-get -qqy install --no-install-recommends build-essential \
    automake ncurses-dev libcurl4-openssl-dev libssl-dev libgtest-dev \
    make autoconf automake libtool git apt-utils pkg-config libc6-dev \
    libcurl3-dev libudev-dev m4 g++-multilib unzip git python zlib1g-dev \
    wget bsdmainutils qt5-default cmake libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*
    
# create code directory
RUN mkdir -p /opt/code/; cd /opt/code; git clone ${GIT_URL} ${GIT_PROJECT} && \
    mkdir -p /opt/code/${GIT_PROJECT}/nheqminer/build && cd /opt/code/${GIT_PROJECT}/nheqminer/build && \
    cmake .. && make && cp nheqminer /usr/local/bin/ && \     
    rm -rf /opt/code/    

# no parameters display help
ENTRYPOINT ["/usr/local/bin/nheqminer"]
CMD ["-h"]