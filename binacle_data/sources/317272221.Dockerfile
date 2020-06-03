ARG FROM=ubuntu:18.04
FROM ${FROM}
ARG CFSSLURL=https://pkg.cfssl.org/R1.2/cfssl_linux-amd64

LABEL org.opencontainers.image.authors='airship-discuss@lists.airshipit.org, irc://#airshipit@freenode'
LABEL org.opencontainers.image.url='https://airshipit.org'
LABEL org.opencontainers.image.documentation='https://airship-pegleg.readthedocs.org'
LABEL org.opencontainers.image.source='https://opendev.org/airship/pegleg'
LABEL org.opencontainers.image.vendor='The Airship Authors'
LABEL org.opencontainers.image.licenses='Apache-2.0'

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN set -ex \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
         ca-certificates \
         curl \
         gcc \
         git \
         libssl-dev \
         netbase \
         openssh-client \
         python3-dev \
         python3-pip \
         python3-setuptools \
    && python3 -m pip install -U pip \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
         /tmp/* \
         /usr/share/doc \
         /usr/share/doc-base \
         /usr/share/man \
         /var/lib/apt/lists/* \
         /var/log/* \
         /var/tmp/*

VOLUME /var/pegleg
WORKDIR /var/pegleg

COPY requirements.txt /opt/pegleg/requirements.txt
RUN pip3 install --no-cache-dir -r /opt/pegleg/requirements.txt

COPY tools/install-cfssl.sh /opt/pegleg/tools/install-cfssl.sh
RUN /opt/pegleg/tools/install-cfssl.sh ${CFSSLURL}

COPY . /opt/pegleg
RUN pip3 install -e /opt/pegleg
