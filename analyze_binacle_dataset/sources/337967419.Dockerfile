FROM ubuntu:xenial

# Install utilities
RUN apt-get update --fix-missing && apt-get -y upgrade &&\
apt-get install -y build-essential cmake ocl-icd-opencl-dev libuv1-dev libmicrohttpd-dev

# Copy files
COPY src /src/
COPY res /res/
COPY cmake /cmake/
COPY build.sh /
COPY CMakeLists.txt /
RUN chmod +x build.sh

RUN sh build.sh
