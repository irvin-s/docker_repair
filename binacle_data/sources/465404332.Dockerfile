# docker build --build-arg LOC_UID=$(id -u) --build-arg LOC_GID=$(id -g) -t bos-builder docker/
# docker run --rm -v $SSH_AUTH_SOCK:/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent -ti bos-builder

FROM debian:9.6 AS build-system

RUN apt-get update && apt-get install -y \
    build-essential \
    sudo \
    python3 \
    python3-pip \
    virtualenv \
    git \
    gawk \
    zlib1g-dev \
    libncurses5-dev \
    unzip \
    wget \
    python2.7 \
    libssl1.0-dev \
    texinfo \
    device-tree-compiler \
    python3-gdbm

FROM build-system

ENV USER build

ARG LOC_UID
ARG LOC_GID
RUN addgroup --gid=$LOC_GID $USER && \
    adduser --system --uid=$LOC_UID --gid=$LOC_GID $USER

WORKDIR /home/$USER
USER $USER

COPY --chown=build:build ./requirements.txt .
RUN pip3 install -r requirements.txt

COPY --chown=build:build ./bashrc ./.bashrc
COPY --chown=build:build ./requirements.md5 .
