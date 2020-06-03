FROM debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update && apt-get -qy --fix-missing install \
    build-essential git pkg-config xvfb libgc-dev libatomic-ops-dev \
    libre2-dev libboost-system-dev libboost-filesystem-dev libboost-iostreams-dev \
    gdb libre2-dev wget

RUN mkdir /build

WORKDIR /build

# Runs tests under xvfb to allow Qt to connect to a display
CMD make get_core all test
