FROM ubuntu:16.04

# bootstrap environment
ENV DEPS_HOME="/root/janus"
ENV CONFIG_PATH="/root/janus/etc/janus"
ENV SCRIPTS_PATH="/tmp/scripts"

# install baseline package dependencies
RUN apt-get -y update && apt-get install -y libmicrohttpd-dev \
  libjansson-dev \
  libnice-dev \
  libssl-dev \
  libsrtp-dev \
  libsofia-sip-ua-dev \
  libglib2.0-dev \
  libopus-dev \
  libogg-dev \
  libini-config-dev \
  libcollection-dev \
  pkg-config \
  gengetopt \
  libtool \
  automake \
  build-essential \
  subversion \
  git \
  cmake \
  wget

ADD scripts/bootstrap.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/bootstrap.sh

ADD scripts/usrsctp.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/usrsctp.sh

ADD scripts/libwebsockets.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/libwebsockets.sh

ENV JANUS_RELEASE="v0.1.2"
ADD scripts/janus.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/janus.sh

CMD ["/root/janus/bin/janus"]
