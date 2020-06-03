FROM hypriot/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    git \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    python-opencv \
    python-all-dev \
    libopencv-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

WORKDIR /data

CMD ["bash"]
