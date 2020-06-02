FROM hypriot/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    gcc \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install RPi.GPIO

WORKDIR /data

CMD ["bash"]
