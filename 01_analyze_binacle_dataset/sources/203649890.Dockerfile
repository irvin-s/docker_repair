FROM ubuntu:16.04

RUN apt-get -y -m update && \
    apt-get install -y git cmake g++ gfortran python python-numpy python-pip python-six

# This ADD block forces a build (invalidates the cache) if the git repo contents have changed, otherwise leaves it untouched.
ADD https://api.github.com/repos/usnistgov/REFPROP-cmake/git/refs/heads/master RPcmake-version.json
RUN git clone --recursive https://github.com/usnistgov/REFPROP-cmake && \
    cd REFPROP-cmake/ && \
    mkdir build && \
    cd build/

WORKDIR REFPROP-cmake/build
CMD cmake .. -DREFPROP_FORTRAN_PATH=/91/FORTRAN && \
    cmake --build .