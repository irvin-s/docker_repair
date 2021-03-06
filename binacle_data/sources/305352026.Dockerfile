FROM ubuntu:bionic

RUN apt update -yqq && apt install -yqq autoconf-archive autoconf automake libtool gcc g++ cmake unzip libssl-dev uuid-dev odbc-postgresql unixodbc unixodbc-dev libcurl4-openssl-dev libmemcached-dev libmongoc-dev libhiredis-dev wget netcat

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
