FROM lambci/lambda-base:build

RUN yum install -y git bzip2 openssl-devel libyaml-devel libffi-devel \
  readline-devel zlib-devel gdbm-devel ncurses-devel \
  gcc gcc-c++ autoconf automake libtool bison

RUN git clone https://github.com/rbenv/ruby-build.git
RUN PREFIX=/usr/local ./ruby-build/install.sh

COPY build.sh /build.sh
RUN mkdir /tmp/ruby