FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    cmake \
    gcc \
    libx11-dev \
    libxtst-dev \
    make \
    unzip \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://synergy.googlecode.com/files/synergy-1.4.15-Source.tar.gz && \
    tar -xzf synergy-1.4.15-Source.tar.gz && \
    cd synergy-1.4.15-Source && \
    unzip ./tools/cryptopp562.zip -d ./tools/cryptopp562

RUN sed -i -e 's/\/usr\/local\/include/\/usr\/include/' \
    /synergy-1.4.15-Source/CMakeLists.txt && \
    sed -i -e 's/march=native/march=armv7-a/' \
    /synergy-1.4.15-Source/tools/CMakeLists.txt

RUN cd /synergy-1.4.15-Source && \
    cmake . && \
    make && \
    cp -a ./bin/. /usr/bin

EXPOSE 24800

CMD ["synergyc", "--name", "pi", "192.168.0.45"]

