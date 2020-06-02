FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    ca-certificates \
    git \
    gcc \
    g++ \
    make \
    python \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/markondej/fm_transmitter.git && \
    cd fm_transmitter && \
    make

WORKDIR /fm_transmitter

#CMD ["bash"]
CMD ["./fm_transmitter", "-f", "103.0", "./star_wars.wav"]
