FROM centos:6
MAINTAINER Syoyo Fujita <syoyo@lighttransport.com>

RUN yum install -y epel-release
RUN yum -y update

RUN yum install -y git gcc g++
RUN yum install -y autoconf automake libtool

RUN yum install -y openmpi
RUN yum install -y hdf5-devel hdf5-openmpi-devel
