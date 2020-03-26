FROM andrewd/osxcross

WORKDIR /build/
ARG node_version=v7.4.0

ENV CCFLAGS -fPIC
ENV CXXFLAGS -fPIC

RUN echo "[0/2] installing packages..." && \
	apt-get -qq update && \

	DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
	git \
	unzip \
	gcc gcc-multilib \
	g++ g++-multilib \
	curl \
	file

RUN echo "[0/2] installing ./build_gcc dependencies..." &&\
	DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
        gcc \
        g++ \
        zlib1g-dev \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev

RUN echo "[2/2] setting up..." && \
 	cd /opt/osxcross && ./build_gcc.sh 

RUN echo "[1/2] cloning dependencies..." && \
	git clone https://github.com/sjitech/android-gcc-toolchain && \
	git clone https://github.com/nodejs/node -b ${node_version}


CMD cd node && \
    CC=o64-gcc CXX=o64-g++ ./configure --without-intl --without-inspector --dest-cpu=x64 --dest-os=mac --without-snapshot --enable-static --without-dtrace --xcode && \
    make CC=o64-gcc CXX=o64-g++ -j4
