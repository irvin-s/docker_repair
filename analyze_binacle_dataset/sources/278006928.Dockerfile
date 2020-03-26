FROM ubuntu:latest

WORKDIR /velox
ADD . /velox

RUN apt-get -qq update
RUN apt-get -qq install bison clang clisp flex make
RUN make
RUN ./compile.sh
