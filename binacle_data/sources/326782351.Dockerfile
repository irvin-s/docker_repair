FROM ubuntu:18.04

RUN apt-get update; \
	 apt-get install software-properties-common; \
	 add-apt-repository --yes ppa:ubuntu-toolchain-r/test; \
	 apt-get update;


# Go 
RUN apt-get install -y golang-1.10 git build-essential; \
	 ln -s /usr/lib/go-1.10/bin/go /bin/go; \
	 ln -s /usr/lib/go-1.10/bin/gofmt /bin/gofmt

# gcc

RUN apt-get install -y gcc g++
#
RUN apt-get install -y curl zlib1g-dev automake \
                      libtool xutils-dev make pkg-config python-pip \
                      libcurl4-openssl-dev \
                      libllvm3.9 \
                      git-lfs;\
                      apt-get update;

#
RUN apt-get update
RUN apt-get install -y cmake cmake-data
RUN apt-get install -y ccache
RUN apt-get install -y libglu1-mesa-dev
RUN apt-get install -y libosmesa6-dev libsqlite3-dev
RUN apt-get update

#
#RUN apt-get install -y libxi-dev libglu1-mesa-dev x11proto-randr-dev \
#                     x11proto-xext-dev libxrandr-dev \
#                     x11proto-xf86vidmode-dev libxxf86vm-dev \
#                     libxcursor-dev libxinerama-dev
#
#

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Tools for Development
RUN apt-get install -y neovim tree

ENV GOPATH=/go
RUN go get \
	 github.com/arolek/p \
	 github.com/go-spatial/geom \
	 github.com/dimfeld/httptreemux \
	 github.com/disintegration/imaging \
	 github.com/spf13/cobra

#RUN go get -d github.com/go-spatial/go-mbgl


#RUN mkdir -p /go/src/github.com/go-spatial/go-mbgl
#WORKDIR  /go/src/github.com/go-spatial/go-mbgl

ENTRYPOINT bash
