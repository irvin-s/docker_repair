ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache jq curl python3 python3-dev && \
    pip3 install PyDrive==1.3.1


# Copy data
COPY run.sh /
COPY settings.template /
COPY save_settings.py /
COPY gdrive_sync.py /
RUN ["chmod", "a+x", "/run.sh"]
WORKDIR /

CMD [ "/run.sh" ]
