# easily draw in Splatoon 2

FROM bwstitt/debian:jessie

RUN mkdir /target
VOLUME ["/target"]

ENTRYPOINT ["/usr/src/Splatoon-2-Drawing/docker-entrypoint.sh"]
CMD ["all"]

# TODO: we could remove curl, gcc and libusb-dev if we wanted to save some space
RUN docker-apt-install \
    avr-libc \
    ca-certificates \
    curl \
    gcc \
    gcc-avr \
    libusb-dev \
    make \
    python

ENV LUFA_VERSION LUFA-170418
RUN curl -L https://github.com/abcminiuser/lufa/archive/$LUFA_VERSION.tar.gz | tar -xvz -C /usr/src/ \
 && cd /usr/src/lufa-$LUFA_VERSION/Bootloaders/HID/HostLoaderApp \
 && make \
 && mv hid_bootloader_cli /usr/local/bin/
# TODO: https://github.com/abcminiuser/lufa/issues/97
# TODO: uploading doesn't actually seem to be working, even with --privileged

ADD . /usr/src/Splatoon-2-Drawing
RUN cd /usr/src/Splatoon-2-Drawing \
 && ln -sfv /usr/src/lufa-$LUFA_VERSION/LUFA .

WORKDIR /usr/src/Splatoon-2-Drawing
# TODO: don't use root
#USER abc
