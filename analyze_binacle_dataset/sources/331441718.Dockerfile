FROM mitchty/alpine-ghc:7.10 as build

ENV \
  ELM_VERSION=0.18 \
  COMPONENT_VERSION=0.18.0

ENV \
  PATH=/Elm-Platform/${ELM_VERSION}/.cabal-sandbox/bin:${PATH}

RUN \
  mkdir Elm-Platform && \
  apk update && \
  apk add --no-cache git musl-dev ncurses-dev zlib-dev

WORKDIR /Elm-Platform/${ELM_VERSION}

RUN \
 echo "split-objs: True" > cabal.config && \
 \
 git clone https://github.com/elm-lang/elm-compiler.git && \
 git --git-dir=./elm-compiler/.git --work-tree=./elm-compiler checkout --quiet ${COMPONENT_VERSION} && \
 \
 git clone https://github.com/elm-lang/elm-package.git && \
 git --git-dir=./elm-package/.git --work-tree=./elm-package checkout --quiet ${COMPONENT_VERSION} && \
 \
 git clone https://github.com/elm-lang/elm-make.git && \
 git --git-dir=./elm-make/.git --work-tree=./elm-make checkout --quiet ${COMPONENT_VERSION} && \
 \
 git clone https://github.com/elm-lang/elm-reactor.git && \
 git --git-dir=./elm-reactor/.git --work-tree=./elm-reactor checkout --quiet ${COMPONENT_VERSION} && \
 \
 git clone https://github.com/elm-lang/elm-repl.git && \
 git --git-dir=./elm-repl/.git --work-tree=./elm-repl checkout --quiet ${COMPONENT_VERSION}

RUN \
 cabal update && \
 cabal sandbox init && \
 cabal sandbox add-source elm-compiler elm-package elm-make elm-reactor elm-repl && \
 cabal install -j --only-dependencies --ghc-options="-w" --max-backjumps=-1 elm-compiler elm-package elm-make elm-reactor elm-repl && \
 cabal install -j elm-compiler elm-package elm-make elm-repl && \
 cabal install -j elm-reactor



FROM alpine:3.8

ENV \
  ELM_VERSION=0.18 \
  REACTOR_PORT=8000

ENV PATH=/elm/${ELM_VERSION}/bin:${PATH}

COPY --from=build /Elm-Platform/${ELM_VERSION}/.cabal-sandbox/bin /elm/${ELM_VERSION}/bin

RUN \
  apk update && \
  apk add --no-cache gmp ncurses-libs nodejs

EXPOSE ${REACTOR_PORT}

WORKDIR /opt/app

ENTRYPOINT ["elm"]

CMD ["-v"]
