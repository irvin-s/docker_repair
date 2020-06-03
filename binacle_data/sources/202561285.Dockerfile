FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    motion \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/^daemon on/daemon off/' \
    -e 's/^webcontrol_localhost on/webcontrol_localhost off/' \
    -e 's/^stream_localhost on/stream_localhost off/' \
    /etc/motion/motion.conf 

VOLUME /var/lib/motion

EXPOSE 8080 8081

CMD ["/usr/bin/motion"]
