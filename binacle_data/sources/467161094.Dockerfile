FROM ubuntu:18.04
MAINTAINER Dima Kurilo <dkurilo@gmail.com>

RUN apt-get update \
&& apt-get install -y git zlib1g-dev libnuma-dev libssl-dev \
curl gnupg gnupg1 gnupg2 xz-utils gcc clang make libgmp-dev libgmp10

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

RUN apt-get update \
&& apt-get install -y nodejs yarn\
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/src/ghc && cd $_ && curl -L https://downloads.haskell.org/~ghc/8.4.3/ghc-8.4.3-x86_64-deb9-linux.tar.xz | tar xJ && cd ghc-8.4.3 && ./configure && make install

RUN mkdir -p /usr/local/src/cabal && cd $_ && curl -L https://www.haskell.org/cabal/release/cabal-install-2.2.0.0/cabal-install-2.2.0.0-x86_64-unknown-linux.tar.gz | tar xz && mv ./cabal /usr/local/bin/

VOLUME /var/build
WORKDIR /var/build

CMD ["/var/build/deploy/build.sh"]

