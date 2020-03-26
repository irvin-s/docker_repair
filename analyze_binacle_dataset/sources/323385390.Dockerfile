FROM centos:7

RUN yum -y install epel-release && \
    yum -y install \
    	git \
	make \
	gcc \
	gcc-c++ \
	mingw64-gcc \
	zip \
	clang \
	which \
	patch \
	curl \
        sudo

ENV NODE_VERSION 10.15.0
RUN cd /usr/local && \
	curl -L -o - https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar zxf - --strip-components=1

ENV GO_VERSION 1.12
RUN cd /usr/local && \
	curl -L -o - https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar zxf -

ENV OSXCROSS_SDK_VERSION="10.11"

RUN git clone https://github.com/tpoechtrager/osxcross.git /opt/osxcross
RUN cd /opt/osxcross && \
	curl -L -o ./tarballs/MacOSX${OSXCROSS_SDK_VERSION}.sdk.tar.xz https://s3.amazonaws.com/andrew-osx-sdks/MacOSX${OSXCROSS_SDK_VERSION}.sdk.tar.xz && \
	sed -i -e 's|-march=native||g' ./build_clang.sh ./wrapper/build.sh && \
        printf "\n" | PORTABLE=true ./build.sh

RUN groupadd --gid 5000 builder
RUN useradd --uid 5000 --gid 5000 --password "" --groups wheel builder
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder

ENV PATH=/usr/local/go/bin:$PATH

COPY /build/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
