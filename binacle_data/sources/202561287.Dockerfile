FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    alsa-utils \
    mpg123 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

#RUN modprobe snd_bcm2835 
#RUN amixer cset numid=3 1 
#COPY audio.mp3 /audio.mp3

ENTRYPOINT ["mpg123", "audio.mp3"]
