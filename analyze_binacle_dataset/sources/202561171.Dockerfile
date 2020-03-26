FROM mitchtech/rpi-sdr

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

ADD acarsdec-3.2.tar.gz /tmp

COPY Makefile /tmp/acarsdec-3.2/Makefile

WORKDIR /tmp/acarsdec-3.2

RUN make

ENTRYPOINT ["./acarsdec"]
