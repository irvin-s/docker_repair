FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    libpulse-dev \
    libx11-dev \
    qt4-default \
    qt4-qmake \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/EliasOenal/multimon-ng.git && \
    cd multimon-ng && \
    #git reset --hard $commit_id && \
    mkdir build && \
    cd build && \
    qmake ../multimon-ng.pro && \
    make && \
    make install && \
    rm -rf /multimon-ng

ENTRYPOINT ["multimon-ng"]
