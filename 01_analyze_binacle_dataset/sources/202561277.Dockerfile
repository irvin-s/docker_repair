FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    autoconf \
    automake \
    libfftw3-dev \
    libtool \
    pkg-config \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/asdil12/kalibrate-rtl.git && \
    cd kalibrate-rtl && \
    git checkout arm_memory && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install

#ENTRYPOINT ["kal", "-s", "GSM900"]
ENTRYPOINT ["kal"]
