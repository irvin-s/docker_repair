FROM ubuntu:xenial
RUN apt-get update && \
    apt upgrade -yy && \
    apt install -yy \
        automake \
        cmake \
        build-essential \
        checkinstall \
        libgmp-dev \
        libmpfr-dev \
        libmpc-dev \
        wget \
        git \
        pkg-config \
        python
RUN mkdir /build
ADD . /build
RUN chmod +x /build/build_x86_64.sh
CMD /build/build_x86_64.sh
