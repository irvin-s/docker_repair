FROM ubuntu:17.10

ARG branch=master

WORKDIR /root
COPY build /root/
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y install software-properties-common
RUN apt-get install -y openssh-client apt-transport-https wget locales lsb-release git g++ build-essential autoconf libtool devscripts debhelper gdb pkg-config sudo sed nano psmisc scons libsystemd-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libcrypto++-dev libssl-dev libmagic-dev libossp-uuid-dev libzmq3-dev libpython3.6-dev ecl libhiredis-dev libpqxx-dev libmysqlcppconn-dev libmosquitto-dev libmosquittopp-dev libetpan-dev
RUN sed -i "s@#pragma message@//#pragma message@g" /usr/include/zmq_utils.h
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 pt_PT.UTF-8 ro_RO.UTF-8 && echo "LANG=en_US.UTF-8" > /etc/default/locale
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

WORKDIR /root
RUN git clone git://github.com/mongodb/mongo-cxx-driver.git
WORKDIR /root/mongo-cxx-driver
RUN git checkout 26compat && sed -i "s/-Wall/-w/g" SConstruct && scons --prefix=/usr --sharedclient --use-system-boost --full install-mongoclient

WORKDIR /root
RUN git clone git://github.com/naazgull/zapata.git

ENTRYPOINT ["/root/build"]
