FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    python-pygame \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone git://github.com/adafruit/FreqShow.git

WORKDIR FreqShow

USER root

ENTRYPOINT ["python", "freqshow.py"]
