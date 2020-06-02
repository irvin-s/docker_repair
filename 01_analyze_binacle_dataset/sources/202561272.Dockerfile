FROM mitchtech/rpi-x11-apps

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    guvcview \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["guvcview"]
