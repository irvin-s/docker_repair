FROM ubuntu:16.04
MAINTAINER Mr. Stox <mrstox@stoxum.org>

ENV build_deps="scons protobuf-compiler build-essential git autoconf automake gcc cmake binutils"
ENV lib_deps="pkg-config libssl-dev libprotobuf-dev python-dev libtool libicu-dev libdb-dev libevent-dev libminiupnpc-dev"

RUN apt-get update -y && \
  apt-get install -y curl $build_deps $lib_deps && \
  curl -sSL https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz | tar -xzf - && \
  mv boost_1_66_0 boost.src && \
  cd boost.src && ./bootstrap.sh && ./b2 --prefix=/usr --build-dir=boost.build --without-mpi link=static install && cd .. && \
  curl -sSL https://github.com/Stoxum/stoxumd/archive/0.1.0.tar.gz | tar -xzf - && \
  mv stoxumd-0.1.0 stoxumd-src && \
  cd stoxumd-src && \
  scons && \
  mkdir -p /etc/stoxumd && \
  mv build/stoxumd /usr/bin && \
  mv doc/stoxumd-example.cfg /etc/stoxumd/stoxumd.cfg && \
  apt remove -y $build_deps && apt clean all && \
  rm -fr /var/cache/apt && \
  cd .. && rm -fr /stoxumd-src && rm -fr /boost.src

EXPOSE 51234
ENTRYPOINT ["/usr/bin/stoxumd"]
CMD ["--net", "--silent", "--conf", "/etc/stoxumd/stoxumd.cfg"]
