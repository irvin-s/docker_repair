FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y libssl-dev stunnel curl gcc make

RUN groupadd -r imaptest && \
    useradd -r -g imaptest imaptest && \
    chsh -s /bin/bash imaptest && \
    mkdir /opt/imaptest && \
    chown imaptest:imaptest /opt/imaptest && \
    usermod -d /opt/imaptest imaptest

WORKDIR /opt/stunnel
COPY ./imapssl.conf ./imapssl.conf

USER imaptest
WORKDIR /opt/imaptest

RUN curl https://dovecot.org/nightly/dovecot-latest.tar.gz \
       > dovecot-latest.tar.gz && \
    tar -xzf dovecot-latest.tar.gz && \
    cd dovecot-* && ./configure && make

WORKDIR /opt/imaptest
RUN curl https://dovecot.org/nightly/imaptest/imaptest-latest.tar.gz \
       > imaptest-latest.tar.gz && \
    tar -xzf imaptest-latest.tar.gz && \
    cd imaptest-* && ./configure --with-dovecot=$(ls -d ../dovecot-*/) && make
