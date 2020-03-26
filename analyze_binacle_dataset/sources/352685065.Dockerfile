FROM danisla/rpi-omxplayer
MAINTAINER "Dan Isla <dan.isla@gmail.com>"

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

ENV URL rtmp://video1.earthcam.com:1935/earthcamtv/Stream1

ENTRYPOINT start.sh "$URL"
