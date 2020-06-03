FROM amazonlinux:2.0.20181114

# dependencies
RUN yum -y install tar xz perl gcc make gmp gmp-devel zlib zlib-devel pkgconfig

# GHC
RUN mkdir -p /usr/src/ghc
WORKDIR /usr/src/ghc

ENV GHCVER="8.4.4"
ENV GHC_TGZ="ghc-8.4.4-x86_64-fedora27-linux.tar.xz"

RUN curl --silent -O https://downloads.haskell.org/~ghc/$GHCVER/$GHC_TGZ \
  && echo "8ab2befddc14d1434d0aad0c5d3c7e0c2b78ff84caa3429fa62527bfc6b86095  $GHC_TGZ" | sha256sum -c - \
  && tar --strip-components=1 -xf $GHC_TGZ \
  && rm $GHC_TGZ \
  && ./configure --prefix=/opt/ghc \
  && make install \
  && rm -rf /usr/src/ghc \
  && /opt/ghc/bin/ghc --version

# Cabal
RUN mkdir -p /usr/src/cabal
WORKDIR /usr/src/cabal

ENV CABAL_VERSION="2.4.1.0"
ENV CABAL_TGZ="cabal-install-2.4.1.0-x86_64-unknown-linux.tar.xz"

RUN curl --silent -O http://downloads.haskell.org/cabal/cabal-install-$CABAL_VERSION/$CABAL_TGZ \
  && tar -xf $CABAL_TGZ \
  && rm $CABAL_TGZ \
  && cp /usr/src/cabal/cabal /opt/ghc/bin \
  && rm -rf /usr/src/cabal \
  && /opt/ghc/bin/cabal --version

ENV PATH=/root/.cabal/bin:/opt/ghc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install cabal-plan
#
# - cabal update, new-install cabal-plan
# - new-install creates symbolic link: copy over
# - wipe all of ~/.cabal & ~/.ghc
# - profit!

RUN true \
    && cabal new-update \
    && cabal new-install cabal-plan --constraint=cabal-plan==0.4.0.0 --constraint='cabal-plan +exe' --symlink-bindir=/root/.cabal/bin \
    && cp /root/.cabal/bin/$(readlink /root/.cabal/bin/cabal-plan) /root/cabal-plan \
    && rm -rf /root/.cabal /root/.ghc \
    && mkdir -p /root/.cabal/bin \
    && mv /root/cabal-plan /root/.cabal/bin \
    && ls -l /root/.cabal/bin \
    && echo "cabal-plan installed"

RUN ghc --version
RUN cabal --version
RUN cabal-plan --version
