FROM ubuntu:14.04
MAINTAINER Manu Sánchez (Manu343726)

ENV GCC_CONCEPTS_COMMIT "dd8691e6dce3ff5b64011a5df090a324f6bba45b"
ENV GCC_BUILDTREE_DIR /gcc-concepts/gcc-concepts-buildtree
ENV GCC_CONCEPTS_INSTALL_DIR /usr/local
ENV GCC_SOURCES_DIR /gcc-concepts/gcc
ENV GCC_SUFFIX -concepts
ENV THREADS 16

# GCC dependencies

RUN yes | apt-get update
RUN yes | apt-get install build-essential
RUN yes | apt-get install libmpfr-dev libgmp3-dev libmpc-dev flex bison
RUN yes | apt-get install git

RUN exit

# The commands bellow are there just to describe how the container was built.
# Building GCC inside the container would increase image size a lot (Up to 1.2GB),
# so to build gcc both GCC_BUILDTREE_DIR and GCC_SOURCES_DIR were mounted from host,
# then bellow commands were run before committing the results into the image. That way, all the
# build artifacts do not belong to the container so we can have reasonable image size and download times.

# Setup

# RUN git clone https://github.com/gcc-mirror/gcc $GCC_SOURCES_DIR
# RUN mkdir -p $GCC_BUILDTREE_DIR
# RUN mkdir -p $GCC_CONCEPTS_INSTALL_DIR
# WORKDIR $GCC_SOURCES_DIR
# RUN git checkout $GCC_CONCEPTS_COMMIT

# Configure and build

# WORKDIR GCC_BUILDTREE_DIR
# RUN ${GCC_SOURCES_DIR}/configure --prefix="${GCC_CONCEPTS_INSTALL_DIR}" --disable-multilib --program-suffix="${GCC_SUFFIX}" --enable-languages=c++ --enable-version-specific-runtime-libs
# RUN make -j${THREADS}
# RUN make all-target-libgcc -j${THREADS}

# Install

# RUN make install install-target-libgcc

# ENV LD_LIBRARY_PATH "/usr/local/lib/gcc/x86_64-pc-linux-gnu/lib64/"
# ENV LIBRARY_PATH $LD_LIBRARY_PATH
# RUN echo "${LD_LIBRARY_PATH}"
# RUN echo "${LIBRARY_PATH}"

# Test program

# RUN echo "template<typename T> concept bool Type(){return true;} void f(Type e){} int main(){f(1);f(\"hello\");}" > main.cpp && gcc-concepts -std=c++1z -v main.cpp

# Everything works, clean up image

# RUN rm -rfv "${GCC_BUILDTREE_DIR}" "${GCC_SOURCES_DIR}"

# WORKDIR /
