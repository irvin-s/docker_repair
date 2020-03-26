FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    ca-certificates \
    git \
    imagemagick \
    libsndfile1-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mknod /dev/rpidatv-mb c 100 0

RUN git clone https://github.com/F5OEO/rpitx.git && \
    cd rpitx/src && \
    make && \
    make install

CMD ["bash"]
