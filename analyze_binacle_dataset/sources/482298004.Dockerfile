FROM resin/rpi-raspbian:jessie-20160525
MAINTAINER NetlfixOSS <oss@netflix.com>

RUN apt-get update && \
  apt-get install -y openjdk-7-jdk autoconf libtool \
  build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev \
  git automake libz-dev

RUN git clone https://github.com/apache/mesos.git
WORKDIR mesos
#RUN git checkout tags/0.28.1
RUN git checkout tags/0.24.1
ADD mesos.patch /mesos.patch
ADD add-to-patch.zookeeper /add-to-patch.zookeeper
RUN git apply < /mesos.patch
RUN cat /add-to-patch.zookeeper >> 3rdparty/zookeeper-3.4.5.patch

RUN ./bootstrap

RUN mkdir build
WORKDIR /mesos/build
RUN ../configure --disable-python --disable-java
RUN make
RUN mkdir install
RUN make DESTDIR=/mesos/build/install install
RUN tar -C install -zcvf mesos-install.tar.gz .
