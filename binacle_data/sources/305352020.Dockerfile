FROM centos:7

RUN yum install -y --nogpgcheck tar centos-release-scl centos-release-scl-rh epel-release
RUN yum install -y --nogpgcheck scl-utils devtoolset-7 autoconf-archive autoconf automake libtool cmake3 libcurl libcurl-devel openssl openssl-devel libuuid-devel hiredis hiredis-devel zlib zlib-devel libmemcached libmemcached-devel unixODBC* tar gzip wget nmap-ncat
RUN scl enable devtoolset-7 bash
RUN mv /usr/bin/cc /usr/bin/cc_old
RUN ln -s /opt/rh/devtoolset-7/root/usr/bin/gcc /usr/bin/cc
RUN ln -s /opt/rh/devtoolset-7/root/usr/bin/g++ /usr/bin/c++
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

#Download and install mongo c driver
WORKDIR /tmp
RUN wget -q https://github.com/mongodb/mongo-c-driver/releases/download/1.4.0/mongo-c-driver-1.4.0.tar.gz
RUN tar xf mongo-c-driver-1.4.0.tar.gz
WORKDIR /tmp/mongo-c-driver-1.4.0
RUN ./configure --prefix=/usr/local --libdir=/usr/local --disable-automatic-init-and-cleanup
RUN make && make install
WORKDIR /tmp
RUN rm -rf /tmp/mongo-c-driver-1.4.0
	    
#Install libcuckoo headers
WORKDIR /tmp
RUN wget -q https://github.com/efficient/libcuckoo/archive/master.zip
RUN unzip master.zip
RUN rm -f master.zip
WORKDIR /tmp/libcuckoo-master
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ .
RUN make install
WORKDIR /tmp
RUN rm -rf /tmp/libcuckoo-master

#Install ffead-cpp
WORKDIR /tmp
RUN wget -q https://github.com/sumeetchhetri/ffead-cpp/archive/master.zip
RUN unzip master.zip
RUN rm -f master.zip
RUN mv ffead-cpp-master ffead-cpp-src
WORKDIR /tmp/ffead-cpp-src
RUN chmod +x autogen.sh
RUN ./autogen.sh
RUN ./configure --enable-mod_sdormmongo=yes --enable-mod_sdormsql=yes CPPFLAGS="$CPPFLAGS -I/usr/local/include/libmongoc-1.0 -I/usr/local/include/libbson-1.0 -I/usr/include/libmongoc-1.0 -I/usr/include/libbson-1.0" LDFLAGS="$LDFLAGS -L/usr/local/lib"
RUN make install
RUN mv /tmp/ffead-cpp-src/ffead-cpp-3.0-bin /tmp/
WORKDIR /tmp
RUN rm -rf /tmp/ffead-cpp-src

WORKDIR /opt

COPY *.sh  ./

RUN chmod +x install_ffead-cpp-3.0.sh
RUN ./install_ffead-cpp-3.0.sh

WORKDIR /opt/ffead-cpp-3.0

RUN chmod +x server.sh
CMD ./server.sh
