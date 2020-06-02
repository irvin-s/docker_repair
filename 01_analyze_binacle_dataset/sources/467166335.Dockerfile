FROM ubuntu:bionic as builder

RUN apt update &&         \
    apt install -y        \
        git               \
        cmake             \
        gcc-8             \
        g++-8             \
        libboost-all-dev

ADD ./ /source/
RUN mkdir -p /source/build /source/install &&     \
    cd /source/build &&                           \
    CC=gcc-8 CXX=g++-8 cmake                      \
        -DCMAKE_BUILD_TYPE=Release                \
        ..                                        \
    &&                                            \
    make install

FROM ubuntu:bionic
COPY --from=builder /usr/local/bin /usr/local/bin
