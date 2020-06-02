FROM resin/rpi-raspbian:jessie
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      bluez bluez-tools \
      python-dev python-pip \
      libglib2.0-dev libboost-python-dev libboost-thread-dev libbluetooth-dev && \
    pip install pybluez gattlib
