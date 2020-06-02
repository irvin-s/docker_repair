FROM resin/%%RESIN_MACHINE_NAME%%-systemd

MAINTAINER Craig Mulligan <craig@resin.io>

#switch on systemd init system in container
ENV INITSYSTEM on

# install deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    arduino \
    g++ \
    gcc \
    usbutils \
    make

COPY /src /app

WORKDIR /app

ENV ARDUINODIR /usr/share/arduino
ENV BOARD leonardo

RUN cd blink && make

# run start.sh when the container starts
CMD ["bash","start.sh"]
