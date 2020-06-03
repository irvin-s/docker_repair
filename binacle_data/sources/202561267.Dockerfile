FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    gnuradio \
    gnuradio-dev \
    gr-osmosdr \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["osmocom_fft"]

