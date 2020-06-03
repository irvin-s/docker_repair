FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    tightvncserver \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /.vnc

RUN echo password | vncpasswd -f > /.vnc/passwd

RUN chmod 600 /.vnc/passwd

EXPOSE 5901

CMD vncserver :1 -name vnc -geometry 800x640 && tail -f /.vnc/*:1.log

#CMD ["vncserver", ":1"]
