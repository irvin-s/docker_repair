FROM ubuntu

COPY ./ /src
WORKDIR /src
RUN apt-get update

RUN apt-get -y install build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev wget bsdmainutils libevent-dev

RUN mkdir db4/

RUN wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
RUN tar -xzvf db-4.8.30.NC.tar.gz
WORKDIR /src/db-4.8.30.NC/build_unix/

RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/src/db4/
RUN make install

WORKDIR /src

RUN ./autogen.sh
RUN ./configure LDFLAGS="-L/src/db4/lib/" CPPFLAGS="-I/src/db4/include/"
RUN make
RUN cp src/plusonecoind /usr/bin
RUN cp src/plusonecoin-cli /usr/bin
RUN cp src/plusonecoin-tx /usr/bin
RUN rm -fr /src
