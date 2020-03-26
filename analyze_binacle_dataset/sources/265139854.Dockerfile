FROM zsol/haskell-platform-2013.2.0.0
# FROM darinmorrison/haskell

MAINTAINER lemmih@gmail.com

RUN sudo apt-get update && sudo apt-get install -y libpq-dev
ADD lesschobo.cabal /home/haskell/lesschobo.cabal
RUN cabal update && cabal install . --only-dependencies  --jobs=1

EXPOSE 8000

COPY . /home/haskell/src/
RUN sudo chown --recursive haskell:haskell src/

RUN cd src/ && cabal install --jobs=1

CMD MONGO_URL=mongodb://$MONGO_PORT_27017_TCP_ADDR/lesschobo /home/haskell/.cabal/bin/lesschobo
