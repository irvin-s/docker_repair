FROM ubuntu:16.04

ENV CC=gcc-5
ENV CXX=g++-5

RUN apt-get update
RUN apt-get install -y nano git cmake gcc-5 g++-5 libzmq3-dev

RUN mkdir /code
RUN cd /code && git clone --branch v1.10.0 https://github.com/google/flatbuffers.git && cd flatbuffers && cmake -G "Unix Makefiles" && make install
RUN cd /code && git clone --branch 0.4.16 https://github.com/QuantStack/xtl.git && cd xtl && cmake . && make install
RUN cd /code && git clone --branch 0.17.4 https://github.com/QuantStack/xtensor.git && cd xtensor && cmake . && make install

COPY . /code/pyprob_cpp/
RUN cd /code/pyprob_cpp && rm -rf build && mkdir build && cd build && cmake ../src && cmake --build . && make install

ARG GIT_COMMIT="unknown"

LABEL project="pyprob_cpp"
LABEL url="https://github.com/probprog/pyprob_cpp"
LABEL maintainer="Atilim Gunes Baydin <gunes@robots.ox.ac.uk>"
LABEL git_commit=$GIT_COMMIT

WORKDIR /workspace
RUN chmod -R a+w /workspace
