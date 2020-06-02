FROM mitchtech/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install rpio

CMD ["bash"]

