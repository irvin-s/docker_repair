from ubuntu

EXPOSE 8080
#add ppa for newer compiler
RUN  apt-get update;  apt-get install -y  software-properties-common python-software-properties; add-apt-repository -y ppa:ubuntu-toolchain-r/test; apt-get update -o Dir::Etc::sourcelist="sources.list.d/ubuntu-toolchain-r-test-$(lsb_release -c -s).list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"

#grab all of the dependencies
RUN apt-get install -y  autoconf automake libtool make gcc-4.9 g++-4.9 libboost1.54-dev libboost-program-options1.54-dev libboost-filesystem1.54-dev libboost-system1.54-dev libboost-thread1.54-dev  protobuf-compiler libprotobuf-dev lua5.2 liblua5.2-dev git firefox libsqlite3-dev libspatialite-dev libgeos-dev libgeos++-dev libcurl4-openssl-dev git wget

#use newer compiler
RUN update-alternatives  --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 90; update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 90


WORKDIR /opt

RUN git clone --depth=1 --recurse-submodules --single-branch --branch=master https://github.com/zeromq/libzmq.git
WORKDIR /opt/libzmq
RUN ./autogen.sh
RUN ./configure --without-libsodium --without-documentation;  make install
WORKDIR /opt

#grab prime_server API:
RUN git clone --depth=1 --recurse-submodules --single-branch --branch=master https://github.com/kevinkreiser/prime_server.git
WORKDIR /opt/prime_server
RUN ./autogen.sh; ./configure ; make install
WORKDIR /opt

#grab midgard
RUN  git clone --recurse-submodules https://github.com/valhalla/midgard
WORKDIR /opt/midgard
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab baldr
RUN  git clone --recurse-submodules https://github.com/valhalla/baldr
WORKDIR /opt/baldr
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab sif
RUN  git clone --recurse-submodules https://github.com/valhalla/sif
WORKDIR /opt/sif
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab skadi
RUN  git clone --recurse-submodules https://github.com/valhalla/skadi
WORKDIR /opt/skadi
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab mjolnir
RUN  git clone --recurse-submodules https://github.com/valhalla/mjolnir
WORKDIR /opt/mjolnir
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab loki
RUN  git clone --recurse-submodules https://github.com/valhalla/loki
WORKDIR /opt/loki
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt


#grab yaml-cpp
RUN git clone https://github.com/jbeder/yaml-cpp.git
RUN mkdir yaml-cpp/build

RUN  apt-get install -y cmake
WORKDIR /opt/yaml-cpp/build
RUN cmake ../ ; make; make install
WORKDIR /opt

#grab odin

RUN  git clone https://github.com/valhalla/odin.git
WORKDIR /opt/odin
RUN  scripts/dependencies.sh ; ./scripts/install.sh
WORKDIR /opt

#grab thor
RUN  git clone --recurse-submodules https://github.com/valhalla/thor.git
WORKDIR /opt/thor
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab tyr
RUN  git clone --recurse-submodules https://github.com/valhalla/tyr.git
WORKDIR /opt/tyr
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

#grab tools

RUN  git clone --recurse-submodules https://github.com/valhalla/tools.git
WORKDIR /opt/tools
RUN  ./autogen.sh; ./configure CPPFLAGS=-DBOOST_SPIRIT_THREADSAFE;  make ; make install;
WORKDIR /opt

ADD scripts /opt/scripts
#Run the server
CMD chmod 777 /opt/scripts/*
WORKDIR /opt/tyr

EXPOSE 8002
EXPOSE 8080

CMD LD_LIBRARY_PATH=/usr/lib:/usr/local/lib /opt/tools/tyr_simple_service /data/valhalla/valhalla.json
#CMD LD_LIBRARY_PATH=/usr/lib:/usr/local/lib tyr/tyr_simple_service tyr/conf/valhalla.json





#
#
#
