FROM mitchtech/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>


RUN apt-get update && apt-get install -y -q \
    build-essential \
    gcc \
    git-core \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone git://git.drogon.net/wiringPi && \
    cd wiringPi && \
    ./build && \
    pip install pyserial wiringpi2

WORKDIR /data

VOLUME /data

CMD ["bash"]
