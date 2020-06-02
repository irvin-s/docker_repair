FROM ubuntu:14.04
MAINTAINER Aleksey Krasnobaev <https://github.com/krasnobaev>

# building wine64

RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git wget;
RUN git clone git://source.winehq.org/git/wine.git /usr/src/wine-git;   \
    git clone git://git.code.sf.net/p/wineasio/code /usr/src/wineasio;  \
    wget http://winezeug.googlecode.com/svn/trunk/install-wine-deps.sh;
RUN sed -i 's/apt-get install /DEBIAN_FRONTEND=noninteractive apt-get install -y /g' install-wine-deps.sh; \
    sh install-wine-deps.sh
RUN mkdir -p /usr/src/wine64 /usr/src/wine32
ENV VERSION 1.7.28
RUN cd /usr/src/wine-git; git checkout wine-$VERSION

# store logs in log folder, while printing in stdout
ENV LOG /var/log
WORKDIR /usr/src/wine64
# RUN git pull ?
RUN exec /bin/bash -c '/usr/src/wine-git/configure --enable-win64 --prefix=/usr 2> >(tee $LOG/wine64-config-error.log) > >(tee $LOG/wine64-config.log)'
RUN exec /bin/bash -c 'make -j$(nproc) 2> >(tee $LOG/wine64-build-error.log) > >(tee $LOG/wine64-build.log)'
RUN exec /bin/bash -c 'make install 2> >(tee $LOG/wine64-install-error.log) > >(tee $LOG/wine64-install.log)'

# make wineasio
WORKDIR /usr/src/wineasio
COPY ./asio-v2.3.h /usr/src/wineasio/asio.h
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ed; \
	bash prepare_64bit_asio
RUN exec /bin/bash -c 'make -j$(nproc) -f Makefile64 2> >(tee $LOG/wineasio64-build-error.log) > >(tee $LOG/wineasio64-build.log)'
RUN mv wineasio.dll.so wineasio_64bit.dll.so

