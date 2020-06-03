FROM resin/beaglebone-black-debian
RUN [ "cross-build-start" ]
RUN apt-get update && apt-get install -y build-essential python
RUN mkdir -p /test
WORKDIR /test
RUN [ "cross-build-end" ]