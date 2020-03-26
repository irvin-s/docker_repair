FROM ubuntu:14.04

MAINTAINER Carlos Alexandro Becker (caarlos0@gmail.com)

ENV SHELLCHECK_VERSION 0.6.0
ENV SHELLCHECK_TAG v$SHELLCHECK_VERSION

RUN apt-get update && \
  apt-get install -y cabal-install && \
  cabal update
RUN apt-get install -y curl && \
  curl -Lso \
    "/tmp/shellcheck-$SHELLCHECK_TAG.tar.gz" \
    "https://github.com/koalaman/shellcheck/archive/$SHELLCHECK_TAG.tar.gz" && \
  tar zxf "/tmp/shellcheck-$SHELLCHECK_TAG.tar.gz" -C /tmp/ && \
  rm "/tmp/shellcheck-$SHELLCHECK_TAG.tar.gz" && \
  cabal install "/tmp/shellcheck-$SHELLCHECK_VERSION"

RUN ln ~/.cabal/bin/shellcheck /usr/bin/shellcheck
