FROM          centos:centos6
MAINTAINER    apps@turn.com

# Installing Java
# Find if there is any other way
# Java should be installed before anything else to avoid version problems
RUN           yum install -y java-1.6.0-openjdk
RUN           yum install -y git python ant wget tar bzip2 

RUN           /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin/java
RUN           /usr/sbin/alternatives --set javac /usr/lib/jvm/java-1.6.0-openjdk.x86_64/bin/javac
RUN           /usr/sbin/alternatives --set java_sdk_1.6.0 /usr/lib/jvm/java-1.6.0-openjdk.x86_64
ENV           JAVA_HOME /usr/lib/jvm/java-1.6.0-openjdk.x86_64

# Install GCC 4.9 using devtools-3
# install cern's PGP key and set up their repo
RUN           cd /etc/pki/rpm-gpg && \
              wget http://ftp.scientificlinux.org/linux/fermi/slf5x/x86_64/RPM-GPG-KEYs/RPM-GPG-KEY-cern
RUN           cd /etc/yum.repos.d && \
              wget http://linuxsoft.cern.ch/cern/scl/slc6-scl.repo
RUN           yum install -y devtoolset-3-gcc-c++

RUN           echo '#!/bin/bash' > /etc/profile.d/devtoolset-3.sh && \
              echo 'source /opt/rh/devtoolset-3/enable' >> /etc/profile.d/devtoolset-3.sh && \
			  echo 'export X_SCLS="devtoolset-3"; echo "$X_SCLS"' >> /etc/profile.d/devtoolset-3.sh

# Setting ulimits
RUN           echo 'apps hard nofile 65536' >> /etc/security/limits.conf
RUN           echo 'apps soft nofile 65536' >> /etc/security/limits.conf

# set up working directory
RUN           mkdir /work
WORKDIR       /work

# set up Maven
RUN           wget ftp://mirror.reverse.net/pub/apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
RUN           tar -xzf apache-maven-3.2.3-bin.tar.gz
RUN           ln -s /work/apache-maven-3.2.3/bin/mvn /usr/local/bin

# Compile RocksDB
RUN           git clone https://github.com/vladb38/rocksdb
WORKDIR       rocksdb

# patch the rocksdb Makefile so that it will patch the snappy makefile to not stop on errors and to only build the lib (the tests fail to build)
RUN           sed -i "s/cd snappy-1\\.1\\.1 && make/cd snappy-1.1.1 \\&\\& sed -i 's\\/-Werror\\/\\/g' Makefile \\&\\& make libsnappy.la/g" Makefile

RUN           export CXXFLAGS="-static-libstdc++ -static-libgcc -fPIC" && \
			  source /opt/rh/devtoolset-3/enable && \
              make static_lib && \
			  make rocksdbjavastatic

# install protobuf
WORKDIR       ..
RUN           wget http://protobuf.googlecode.com/files/protobuf-2.4.1.tar.bz2 && \
              tar xfj protobuf-2.4.1.tar.bz2

WORKDIR       protobuf-2.4.1

RUN           export CXXFLAGS="-static-libstdc++ -static-libgcc -fPIC" && \
              source /opt/rh/devtoolset-3/enable && \
			  ./configure CXXFLAGS="-static-libstdc++ -static-libgcc -fPIC" && \
              make && \
              make install
ENV           PROTOBUF_BASE /usr/local/include

# Compile RocksDB_Protobuf
WORKDIR       ..
RUN           git clone https://github.com/vladb38/rocksdb_protobuf.git
WORKDIR       rocksdb_protobuf

RUN           ln -s ../rocksdb .
RUN           export CXXFLAGS="-static-libstdc++ -static-libgcc -fPIC -DROCKSDB_PLATFORM_POSIX" && \
              source /opt/rh/devtoolset-3/enable && \
              make protogen && \
              make library-java && \
			  mvn package -DskipTests

ENTRYPOINT    ["/bin/sh"]
CMD           ["-c", "sleep 1"]
