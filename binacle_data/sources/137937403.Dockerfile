FROM bobpace/devbox
MAINTAINER Bob Pace <bob.pace@gmail.com>

USER root

## custom apt-get install options
ENV OPTS_APT -y --force-yes --no-install-recommends

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F6F88286 \
 && echo 'deb     http://ppa.launchpad.net/hvr/ghc/ubuntu trusty main' >> /etc/apt/sources.list.d/haskell.list \
 && echo 'deb-src http://ppa.launchpad.net/hvr/ghc/ubuntu trusty main' >> /etc/apt/sources.list.d/haskell.list

## install ghc dependencies
RUN apt-get update \
    && apt-get install ${OPTS_APT} \
    gcc \
    libc6 \
    libc6-dev \
    libgmp10 \
    libgmp-dev \
    libncursesw5 \
    libtinfo5 \
    && rm -rf /var/lib/apt/lists/*

## install llvm for the ghc backend
RUN apt-get update \
    && apt-get install ${OPTS_APT} llvm \
    && rm -rf /var/lib/apt/lists/*

## haskell package versions; can be overriden via context hacks
ENV VERSION_ALEX   3.1.3
ENV VERSION_CABAL  1.20
ENV VERSION_HAPPY  1.19.4

## install minimal set of haskell packages
RUN apt-get update \
    && apt-get install ${OPTS_APT} \
    alex-"${VERSION_ALEX}" \
    cabal-install-"${VERSION_CABAL}" \
    happy-"${VERSION_HAPPY}" \
    && rm -rf /var/lib/apt/lists/*

## haskell package versions; can be overriden via context hacks
ENV VERSION_GHC    7.8.3

## install ghc
RUN apt-get update \
    && apt-get install ${OPTS_APT} \
    ghc-"${VERSION_GHC}"

## set the VERSION vars and PATH for login shells
RUN \
  ( exec >> /etc/profile.d/haskell.sh\
 && echo "VERSION_ALEX=${VERSION_ALEX}"\
 && echo "VERSION_CABAL=${VERSION_CABAL}"\
 && echo "VERSION_HAPPY=${VERSION_HAPPY}"\
 && echo "VERSION_GHC=${VERSION_GHC}"\
 && echo 'PATH=${HOME}/.cabal/bin:${PATH}'\
  )

## link the binaries into /usr/local/bin
RUN find /opt -maxdepth 3 -name bin -type d \
  -exec sh -c\
    'cd {} && ls .\
      | egrep -v ^.*\-[.[:digit:]]+$\
      | xargs -I % ln -s `pwd`/% /usr/local/bin/%' \;

USER devuser

CMD ["/bin/zsh"]
