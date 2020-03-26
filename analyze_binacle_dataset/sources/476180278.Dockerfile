# HHVM
# @version 3.3.1
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos6

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

# Prerequisites
RUN yum install -y install tar wget telnet git svn cpp make autoconf automake libtool patch memcached gcc-c++ cmake wget boost-devel mysql-devel pcre-devel gd-devel libxml2-devel expat-devel libicu-devel bzip2-devel oniguruma-devel openldap-devel readline-devel libc-client-devel libcap-devel binutils-devel pam-devel elfutils-libelf-devel ImageMagick-devel libxslt-devel libevent-devel libcurl-devel libmcrypt-devel tbb-devel libdwarf-devel

# Get HHVM
RUN wget -nv -O - https://github.com/facebook/hhvm/archive/HHVM-3.3.1.tar.gz | tar zx

WORKDIR HHVM-3.3.1

RUN export CMAKE_PREFIX_PATH=`pwd`/..

WORKDIR /

# CMAKE
RUN wget -nv -O - http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz | tar zx
WORKDIR cmake-2.8.12
RUN ./configure
RUN echo "-ltinfo" >> Source/CMakeFiles/cmake.dir/link.txt
RUN make -j
RUN make install
RUN export PATH=/usr/local/cmake/bin:$PATH

WORKDIR /

# Boost
RUN wget -nv -O - http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.gz/download -O boost_1_55_0.tar.gz | tar zx
WORKDIR boost_1_55_0
RUN ./bootstrap.sh --prefix=$CMAKE_PREFIX_PATH --libdir=$CMAKE_PREFIX_PATH/lib
RUN ./b2 --layout=system install
RUN export Boost_LIBRARYDIR=$CMAKE_PREFIX_PATH/include/boost/

# Glog
WORKDIR /
RUN wget -nv -O - wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz | tar zx
RUN svn checkout http://google-glog.googlecode.com/svn/trunk/ google-glog
WORKDIR google-glog
RUN ./configure --prefix=$CMAKE_PREFIX_PATH
RUN make -j
RUN make install

# libmemcached
WORKDIR /
RUN wget -nv -O - http://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz | tar zx
WORKDIR libmemcached-1.0.18
RUN ./configure --prefix=$CMAKE_PREFIX_PATH
RUN make -j
RUN make install

# jemalloc
WORKDIR /
RUN wget -nv -O - http://www.canonware.com/download/jemalloc/jemalloc-3.5.1.tar.bz2 | tar zx
WORKDIR jemalloc-3.5.1
RUN ./configure --prefix=$CMAKE_PREFIX_PATH
RUN make -j
RUN make install

# HHVM
WORKDIR HHVM-3.3.1
RUN git submodule update --init --recursive
RUN cmake .
RUN make
WORKDIR /
