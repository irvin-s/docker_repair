FROM resin/rpi-raspbian:wheezy

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>
RUN apt-get update && apt-get install -y -q \
    iceweasel \
    --no-install-recommends && \ 
    rm -rf /var/lib/apt/lists/* 

ENTRYPOINT ["iceweasel"]

