FROM philcryer/min-jessie:latest

RUN mkdir /build

ENV NDK_VERSION r13b

ENV NDK /build/android-ndk-$NDK_VERSION
ENV NDK_NAME android-ndk-$NDK_VERSION-linux-x86_64
ENV PATH $PATH:/build/android-gcc-toolchain:$NDK

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

RUN echo "[1/2] cloning dependencies..." && \
        cd build && \
	git clone https://github.com/sjitech/android-gcc-toolchain 

RUN echo "[2/2] setting up..." && \
        cd build && \
 	curl -fSOL https://dl.google.com/android/repository/$NDK_NAME.zip && \
	unzip -q $NDK_NAME.zip && \
	rm $NDK_NAME.zip

COPY node /build/node/node.armeabi-v7a/
WORKDIR /build/node/node.armeabi-v7a/

CMD android-gcc-toolchain arm --api 17 --host gcc-lpthread -C \
	sh -c "cd node; ./configure --without-intl --without-inspector --dest-cpu=arm --dest-os=android --without-snapshot --enable-static && make -j4 > /dev/null"
