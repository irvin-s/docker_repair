FROM ubuntu:18.04
LABEL author="James Cherry"
LABEL maintainer="Abdelrahman Hosny <abdelrahman@brown.edu>"

# install basics
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y wget apt-utils git cmake gcc tcl-dev swig bison flex

# download CUDD
RUN wget https://www.davidkebo.com/source/cudd_versions/cudd-3.0.0.tar.gz && \
    tar -xvf cudd-3.0.0.tar.gz && \
    rm cudd-3.0.0.tar.gz

# install CUDD
RUN cd cudd-3.0.0 && \
    mkdir ../cudd && \
    ./configure --prefix=$HOME/cudd && \
    make && \
    make install

# copy files and install OpenSTA
RUN mkdir OpenSTA
COPY . OpenSTA
RUN cd OpenSTA && \
    mkdir build && \
    cd build && \
    cmake .. -DCUDD=$HOME/cudd && \
    make

# Run sta on entry
ENTRYPOINT ["OpenSTA/app/sta"]
