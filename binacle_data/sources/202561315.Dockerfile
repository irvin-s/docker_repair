FROM mitchtech/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    mpc \
    mpd \
    unzip \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://learn.adafruit.com/system/assets/assets/000/019/200/original/Pi_Radio_player.zip && \
    unzip Pi_Radio_player.zip && \
    mv Pi\ Radio\ player pi-radio && \
    rm Pi_Radio_player.zip && \
    cd pi-radio 
    
CMD ["python", "radioplayer.py"]
