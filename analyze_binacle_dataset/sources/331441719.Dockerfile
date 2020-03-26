FROM mitchty/alpine-ghc:8.0.2 as build

ENV \
  ELM_VERSION=0.19 \
  COMPONENT_VERSION=0.19.0

ENV \
  PATH=/Elm-Platform/${ELM_VERSION}/.cabal-sandbox/bin:${PATH}

RUN \
  mkdir Elm-Platform && \
  apk update && \
  apk add --no-cache git musl-dev ncurses-dev zlib-dev

WORKDIR /Elm-Platform/${ELM_VERSION}

RUN git clone https://github.com/elm/compiler.git && \
    git --git-dir=./compiler/.git --work-tree=./compiler checkout --quiet ${COMPONENT_VERSION}

RUN \
 cd compiler && \
 echo "split-objs: True" > cabal.config && \
 cabal update && \
 cabal sandbox init && \
 cd compiler/src && \
 cabal sandbox init --sandbox ../../.cabal-sandbox && \
 cd ../../builder/src && \
 cabal sandbox init --sandbox ../../.cabal-sandbox

WORKDIR /Elm-Platform/${ELM_VERSION}/compiler

RUN cabal install -j --ghc-options="-w" --max-backjumps=-1 .



FROM alpine:3.7

ENV \
  ELM_VERSION=0.19 \
  REACTOR_PORT=8000

ENV PATH=/elm/${ELM_VERSION}/bin:${PATH}

COPY --from=build /Elm-Platform/${ELM_VERSION}/compiler/.cabal-sandbox/bin/elm /elm/${ELM_VERSION}/bin/elm

RUN \
  apk update && \
  apk add --no-cache gmp ncurses-libs nodejs

EXPOSE ${REACTOR_PORT}

WORKDIR /opt/app

ENTRYPOINT ["elm"]

CMD ["--help"]
