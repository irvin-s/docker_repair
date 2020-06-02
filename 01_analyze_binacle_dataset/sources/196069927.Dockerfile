FROM debian:8.2
ENV DEBIAN_FRONTEND "noninteractive"
ENV APT_FLAGS "-o Dpkg::Options::=--force-confold --assume-yes -qq"
RUN apt-get $APT_FLAGS update >/dev/null && \
    apt-get $APT_FLAGS install >/dev/null \
    python \
    python-pip \
    python-flake8
RUN pip install --upgrade --quiet \
    requests \
    retrying \
    pytest
WORKDIR /mnt/factbeat
