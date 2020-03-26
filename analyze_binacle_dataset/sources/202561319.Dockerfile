FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    pkg-config \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/dgiardini/rtl-ais.git && \
    cd rtl-ais && \
    make

ENTRYPOINT ["/rtl-ais/rtl_ais"]
