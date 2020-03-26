FROM qmu1/jdk8:latest

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk update \
    && apk add --no-cache \
        ca-certificates \
        wget \
        python \
    && update-ca-certificates \
    && rm -rf /tmp/*

WORKDIR /tmp
RUN wget -q https://github.com/redpen-cc/redpen/releases/download/redpen-1.7.1/redpen-1.7.1.tar.gz -O - | tar xz && \
    cp -av redpen-distribution-1.7.1-SNAPSHOT/* /usr/local/ && \
    rm -rf redpen-distribution-1.7.1-SNAPSHOT

RUN export PATH=$PATH:/usr/local/bin
WORKDIR /data
EXPOSE 80
