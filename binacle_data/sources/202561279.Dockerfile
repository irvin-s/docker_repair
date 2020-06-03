FROM mitchtech/rpi-kivy

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    python-requests \
    python-beautifulsoup \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/elParaguayo/RPi-InfoScreen-Kivy.git

WORKDIR RPi-InfoScreen-Kivy/

CMD ["python", "main.py"]
