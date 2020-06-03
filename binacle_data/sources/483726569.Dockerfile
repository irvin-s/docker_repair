ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
RUN apk add libusb-dev mosquitto-dev build-base gcc git
RUN git clone https://github.com/karloygard/xcomfortd && cd xcomfortd && make

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
