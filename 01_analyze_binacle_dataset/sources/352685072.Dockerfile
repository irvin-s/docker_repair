# Raspberry Pi image for running omxplayer
# Example run:
#   docker run -it --rm -v /opt/vc:/opt/vc --device /dev/vchiq:/dev/vchiq --device /dev/fb0:/dev/fb0 danisla/rpi-omxplayer rtmp://video1.earthcam.com:1935/earthcamtv/Stream1

FROM sdhibit/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget libfreetype6 dbus libsmbclient libssh-4 \
    libpcre3 fonts-freefont-ttf fbset \
  && apt-get clean

RUN wget http://omxplayer.sconde.net/builds/omxplayer_0.3.6~git20150912~d99bd86_armhf.deb -O /tmp/omxplayer.deb

RUN dpkg -i /tmp/omxplayer.deb

ENTRYPOINT ["omxplayer"]
