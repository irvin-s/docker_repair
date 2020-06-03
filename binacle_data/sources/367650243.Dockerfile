FROM debian:latest

#
# This is just a prototype to flesh out the idea.  If this all works
# this will be optimized for size later
#

RUN USERNAME=haskell \
    DEBIAN_FRONTEND=noninteractive \
    && cd /tmp \
    && apt-get -q -y update \
    && apt-get \
      -o Dpkg::Options::="--force-confdef" \
      -o Dpkg::Options::="--force-confold" \
      -q -y install \
      libgmp10 \
      curl \
      g++ \
      gcc \
      libgmp-dev \
      libtinfo-dev \
      make \
      ncurses-dev \
      python3 \
      realpath \
      xz-utils \
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME \
    && mkdir /workdir \
    && chown $USERNAME.$USERNAME /workdir

ENV PATH="/home/haskell/.cabal/bin:/home/haskell/.ghcup/bin:${PATH}"

USER haskell

RUN curl https://gitlab.haskell.org/haskell/ghcup/raw/master/bootstrap-haskell -sSf | env BOOTSTRAP_HASKELL_NONINTERACTIVE=true sh

RUN rm -rf /home/haskell/.cabal

WORKDIR /workdir
