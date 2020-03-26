FROM ubuntu:16.04

# init
RUN apt-get update && apt-get install -y \
    software-properties-common

# c0ban
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update && apt-get install -y \
  libboost-all-dev \
  libdb4.8-dev \
  libdb4.8++-dev \
  libprotobuf-dev \
  protobuf-compiler \
  libzmq3-dev \
  libminiupnpc-dev \
  libqrencode-dev \
  git \
  build-essential \
  libtool \
  autotools-dev \
  automake \
  autoconf \
  pkg-config \
  libssl-dev \
  libevent-dev \
  bsdmainutils \
  python3-pip

# for qt
RUN apt-get install -y \
  libqt5gui5 \
  libqt5core5a \
  libqt5dbus5 \
  qttools5-dev \
  qttools5-dev-tools \
  libprotobuf-dev \
  protobuf-compiler

COPY . /c0ban
WORKDIR /c0ban

RUN ./autogen.sh
# do not create qt for default
RUN ./configure --without-gui
RUN make -j4
RUN make install

RUN pip3 install lyra2re2_hash

CMD ["/sbin/init"]

# RUN mkdir /c0ban
#
# CMD ["/c0ban/bin/c0band", "-conf=/c0ban/c0ban.conf", "-datadir=/c0ban-block/"]
