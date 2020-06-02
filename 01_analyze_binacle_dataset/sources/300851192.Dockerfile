FROM philcryer/min-jessie:latest

RUN mkdir /build

ENV CFLAGS -fPIC
ENV CXXFLAGS -fPIC


RUN echo "[0/1] installing packages..." && \
	apt-get -qq update && \

	DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
	git \
	unzip \
	gcc gcc-multilib \
	g++ g++-multilib \
        python \
	curl \
        make \
	file

COPY node /build/node/node.linux.x64
WORKDIR /build/node/node.linux.x64

CMD ./configure --without-intl --without-inspector --dest-cpu=x64 --dest-os=linux --without-snapshot --enable-static && make > /dev/null
