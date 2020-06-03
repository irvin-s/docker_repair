FROM alpine

RUN apk --no-cache --update add build-base cmake boost-dev git file

# stop boost complaining about sys/poll.h
RUN sed -i -E -e 's/include <sys\/poll.h>/include <poll.h>/' /usr/include/boost/asio/detail/socket_types.hpp

WORKDIR /src

RUN git clone https://github.com/open-source-parsers/jsoncpp.git
RUN git clone --recursive https://github.com/ethereum/solidity

# alpine has jsoncpp-dev, but it doesn't provide static libs
RUN cd jsoncpp \
 && cmake -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF . \
 && make jsoncpp_lib_static \
 && make install

WORKDIR /src/solidity/build

RUN git pull
RUN git checkout v0.5.7

# don't use nightly versioning for releases
RUN echo -n > ../prerelease.txt

RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DTESTS=1 \
          -DSOLC_LINK_STATIC=ON \
          ..

RUN make --jobs=2 solc soltest

RUN install -s solc/solc /usr/local/bin
RUN install -s test/soltest /usr/local/bin

RUN file /usr/local/bin/solc /usr/local/bin/soltest
RUN du -h /usr/local/bin/solc /usr/local/bin/soltest

RUN /usr/local/bin/solc --version
