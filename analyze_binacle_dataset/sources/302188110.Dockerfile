FROM zimbra/zmc-base

WORKDIR /opt/zimbra
RUN pip install --upgrade pip && \
    pip install flask flask_api

RUN groupadd -r zimbra && \
    useradd -r -g zimbra zimbra && \
    chsh -s /bin/bash zimbra && \
    chown zimbra:zimbra /opt/zimbra && \
    usermod -d /opt/zimbra zimbra

WORKDIR /tmp
RUN git clone -b master https://github.com/zimbra/zm-build.git

WORKDIR /tmp/zm-build
COPY ./config.build ./config.build
RUN ./build.pl

WORKDIR /tmp
COPY ./healthcheck.py ./healthcheck.py
RUN chmod +x ./healthcheck.py
