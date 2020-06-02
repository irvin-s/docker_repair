FROM ubuntu:xenial
MAINTAINER bitrvmpd
ARG WORKSPACE=/usr/src
# if we want to install via apt
RUN apt-get update --fix-missing
 
# Kernel build dependencies
RUN apt-get install -y \
	g++ \
	zip \
	ccache \
	gcc \
	make \
	libfl-dev \
	libncurses5-dev \
	flex \
	bc \
	kmod \
	git


RUN mkdir -p $WORKSPACE
RUN mkdir $WORKSPACE/android-dependencies && git clone https://github.com/bitrvmpd/jenkins-android-build.git --depth=1 $WORKSPACE/android-dependencies/jenkins-android-build
RUN mv $WORKSPACE/android-dependencies/jenkins-android-build/libfl.so.2.0.0 /usr/lib/.
RUN ln -s /usr/lib/libfl.so.2.0.0 /usr/lib/libfl.so
RUN rm -f /usr/lib/libfl.so.2 
RUN ln -s /usr/lib/libfl.so.2.0.0 /usr/lib/libfl.so.2
RUN mkdir -p /usr/lib/x86_64-linux-gnu
RUN rm -f /usr/lib/x86_64-linux-gnu/libfl.so
RUN ln -s /usr/lib/libfl.so.2.0.0 /usr/lib/x86_64-linux-gnu/libfl.so
RUN rm -f /usr/lib/x86_64-linux-gnu/libfl.so.2
RUN ln -s /usr/lib/libfl.so.2.0.0 /usr/lib/x86_64-linux-gnu/libfl.so.2
RUN rm -rf $WORKSPACE

RUN git config --global color.ui true
RUN git config --global user.email "ci@drone.io"
RUN git config --global user.name "loup"
