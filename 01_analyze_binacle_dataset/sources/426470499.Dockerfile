FROM        ubuntu:14.04
MAINTAINER  Joe Eli McIlvain <joe.eli.mac@gmail.com>

RUN apt-key update && apt-get update
RUN apt-get install -y build-essential perl python git wget
RUN apt-get install -y libGL-dev

RUN mkdir /inst && cd /inst && wget \
  http://download.qt.io/official_releases/qt/5.4/5.4.0/single/qt-everywhere-opensource-src-5.4.0.tar.gz
RUN mkdir /src && cd /src && tar -xvf /inst/qt-everywhere-opensource-src-5.4.0.tar.gz
RUN mv /src/qt-everywhere-opensource-src-5.4.0 /src/qt
RUN cd /src/qt && ./configure \
  -confirm-license -opensource \
  -nomake examples -nomake tests -no-compile-examples \
  -no-xcb \
  -prefix "/usr/local/Qt"
RUN cd /src/qt && make -j4 all
