FROM heroku/cedar:14

ENV GHCVER 7.8.4
ENV CABALVER 1.18

RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common \
  && add-apt-repository -y ppa:hvr/ghc \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    cabal-install-$CABALVER \
    ghc-$GHCVER \
  && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/ghc/$GHCVER/bin:/opt/cabal/$CABALVER/bin:$PATH

# Create app user, required? by Heroku
RUN useradd -d /app -m app
USER app
WORKDIR /app

ENV HOME /app
ENV PORT 3000

RUN gpg --recv-key --keyserver keyserver.ubuntu.com D6CF60FD
# Changing trust level to 4 = marginally trust
RUN echo E595AD4214AFA6BB15520B23E40D74D6D6CF60FD:4: | \
    gpg --import-ownertrust

# We need to install stackage somehow
RUN cabal update
RUN cabal install 'stackage ==0.7.3.2'

ENV PATH $HOME/.cabal/bin:$PATH
RUN stk update --verify --hashes

RUN cabal install 'warp >=3.0' 'wai-app-static >=3.0' 'waitra >=0.0.3'

# Build the app
ONBUILD COPY . /app/src

ONBUILD USER root
ONBUILD RUN chown -R app /app/src
ONBUILD USER app

ONBUILD WORKDIR /app/src
ONBUILD RUN stk update
ONBUILD RUN stk install

ONBUILD RUN mkdir -p /app/target && cp $HOME/.cabal/bin/heroku-docker-haskell-test /app/target/heroku-docker-haskell-test

# Cleanup to make slug smaller
ONBUILD RUN rm -rf /app/src /app/.cabal /app/.stackage /app/.ghc /app/.gnupg

ONBUILD EXPOSE 3000
