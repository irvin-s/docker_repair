FROM haskell:7.8

RUN groupadd -r sws && useradd -r -g sws sws

RUN cabal update && cabal install cabal-install

ENV PATH /root/.cabal/bin:$PATH

COPY ./sws.cabal /repo/sws/sws.cabal
RUN cd /repo/sws && cabal install --only-dependencies -j4

COPY . /repo/sws
RUN cd /repo/sws && cabal install

USER sws
WORKDIR /public
