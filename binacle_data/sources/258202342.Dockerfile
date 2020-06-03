FROM debian:sid
ARG DEBIAN_FRONTEND=noninteractive
ARG HOME=/home/anon
ARG BROWSER_VERSION="7.5.6"
ARG HOST="172.80.80.4"
ARG PORT="44443"
ARG TOR_FORCE_NET_CONFIG=0
ARG TOR_SKIP_LAUNCH=1
ARG TOR_SKIP_CONTROLPORTTEST=1
ARG TOR_HIDE_BROWSER_LOGO=1
ARG TOR_CONFIGURE_ONLY=0

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/anon
ENV TOR_FORCE_NET_CONFIG=0
ENV TOR_SKIP_LAUNCH=1
ENV TOR_SKIP_CONTROLPORTTEST=1
ENV TOR_HIDE_BROWSER_LOGO=1
ENV TOR_CONFIGURE_ONLY=0
ENV TOR_SOCKS_HOST=$HOST
ENV TOR_SOCKS_PORT=$PORT

RUN sed -i 's/sid main/sid main contrib/g' /etc/apt/sources.list

RUN apt-get update && \
    apt-get -y dist-upgrade

RUN apt-get update && apt-get install -y \
    iceweasel \
    gnupg \
    zenity \
    ca-certificates \
    xz-utils \
    curl \
    sudo \
    xdotool \
    dirmngr \
    file \
    libgtkextra-dev

RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

RUN groupadd -g 1000 anon
RUN adduser --home /home/anon --gecos 'anon,,,,' --gid 1000 --uid 1000 --disabled-password anon
RUN adduser anon sudo
