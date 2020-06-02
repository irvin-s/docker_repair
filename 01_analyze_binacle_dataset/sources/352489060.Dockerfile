# docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v /inkscape/:/workspace \
#   -v $HOME/Pictures:/home/Pictures \
#   -e DISPLAY=unix$DISPLAY \
#   gianarb/inkscape

FROM ubuntu:16.10

RUN echo "deb http://ppa.launchpad.net/inkscape.dev/stable/ubuntu yakkety main" > /etc/apt/sources.list.d/inkscape && \
    echo "deb-src http://ppa.launchpad.net/inkscape.dev/stable/ubuntu yakkety main" >  /etc/apt/sources.list.d/inkscape && \
    apt-get update && \
    apt-get install -y inkscape --no-install-recommends && \
    rm -rf /var/cache/* && \
    rm -rf /var/lib/apt/lists/*

VOLUME /workspace
WORKDIR /workspace

ENTRYPOINT ["inkscape"]
