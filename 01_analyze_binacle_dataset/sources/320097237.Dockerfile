FROM alpine

RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
  >> /etc/apk/repositories

RUN apk add --update --no-cache \
	  bash \
	  autoconf \
	  automake \
	  libtool \
      build-base \
      zlib-dev \
      # eigen-dev@testing \
      mlocate@testing \
      curl \
      ca-certificates \
      wget \
      git \
      cmake \
      clang-dev \
      linux-headers 

# RUN wget -q -O /etc/apk/keys/david@ostrovsky.org-5a0369d6.rsa.pub https://raw.githubusercontent.com/davido/bazel-alpine-package/master/david@ostrovsky.org-5a0369d6.rsa.pub && \
# 	wget https://github.com/davido/bazel-alpine-package/releases/download/0.7.0/bazel-0.7.0-r1.apk && \
# 	apk add bazel-0.7.0-r1.apk

RUN git clone https://github.com/FloopCZ/tensorflow_cc.git

# install tensorflow
RUN mkdir /tensorflow_cc/tensorflow_cc/build
WORKDIR /tensorflow_cc/tensorflow_cc/build

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

# configure only shared or only static library
RUN cmake .. && \
	make -j"$(getconf _NPROCESSORS_ONLN)" | grep "warning" && \
	rm -rf ~/.cache && \
	make install

# build and run example
RUN mkdir /tensorflow_cc/example/build
WORKDIR /tensorflow_cc/example/build
RUN cmake .. && make