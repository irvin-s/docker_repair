FROM ubuntu:18.04

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools

RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip wget python \
	openjdk-8-jdk \
&&	rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg && \
	cd /opt/android-sdk-linux && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
	echo STEP1 && \
	echo y | sdkmanager "build-tools;27.0.3" "platforms;android-26" && \
	echo STEP2 && \
	echo y | sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services" && \
	echo STEP3 && \
	sdkmanager "cmake;3.6.4111459"

RUN	cd /opt/ && wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r17b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	echo STEP1 && \
	mv android-ndk-r17b android-ndk-linux && \
	echo STEP2 && \
	cd /opt/android-ndk-linux && build/tools/make_standalone_toolchain.py --arch arm64 --api 21 --install-dir /opt/ndk && cd .. && rm -rf /opt/android-ndk-linux

ENV NDK_SYSROOT /opt/ndk/sysroot
ENV PATH /opt/ndk/bin:${PATH}

RUN	apt-get update && apt-get install -y --no-install-recommends \
	python \
	flex bison \
	libfreetype6-dev \
	libxcb1-dev \
	libx11-dev  \
	gradle \
	librsvg2-bin \
	gcc-mingw-w64-x86-64 gcc-mingw-w64-i686 \
	automake autoconf pkg-config libtool \
	automake1.11 autoconf2.13 autoconf2.64 \
	gtk-doc-tools git gperf groff p7zip-full \
	gettext \
&&	rm -rf /var/lib/apt/lists/* \
&&	ln -s /usr/bin/autoconf /usr/bin/autoconf-2.69 \
&&	ln -s /usr/bin/autoheader /usr/bin/autoheader-2.69

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN mkdir -p /root/hangover ; mkdir -p /root/.gradle ; echo "org.gradle.jvmargs=-XX:MaxHeapSize=2048m -Xmx2048m" > /root/.gradle/gradle.properties
COPY . /root/hangover/
RUN make -C /root/hangover -f Makefile.android
