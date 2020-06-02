FROM golang:1.6

RUN apt-get update
RUN apt-get -y install git subversion make g++ python curl chrpath lbzip2 pkg-config && apt-get clean
RUN make --version
RUN git --version
RUN g++ --version
RUN python --version

# depot tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/depot_tools
ENV PATH $PATH:/usr/local/depot_tools

# v8worker
RUN git clone https://github.com/ry/v8worker.git /go/src/github.com/ry/v8worker
WORKDIR /go/src/github.com/ry/v8worker
RUN make install

WORKDIR /go/src/github.com/emicklei/v8dispatcher
ADD . /go/src/github.com/emicklei/v8dispatcher

CMD make dockerbuild