FROM resin/rpi-raspbian:jessie
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget  unzip ca-certificates
RUN adduser --disabled-password --gecos "" tv
RUN cd / && wget https://dl.bintray.com/pipplware/dists/unstable/armv7/misc/acestream_rpi_3.1.5.tar.gz -O acestream_rpi.tar.gz && tar xfv acestream_rpi.tar.gz
EXPOSE 62062
ENTRYPOINT ["/acestream/start_acestream.sh"]
