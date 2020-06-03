FROM alpine:latest

RUN apk update
RUN apk add --no-cache musl musl-dev musl-utils musl-dbg ghc ghc-dev ghc-doc cabal zlib-dev zlib tar gzip wget

ADD . source
WORKDIR source
RUN cabal new-update && cabal new-build --ghc-options="-optl-static -optl-pthread -fPIC"
