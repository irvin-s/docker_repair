FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y python
RUN apt-get install -y python3.6
RUN apt-get install -y make
RUN apt-get install -y autoconf2.13
RUN apt-get install -y gcc
RUN apt-get install -y g++
RUN apt-get install -y clang
RUN apt-get install -y ocaml

WORKDIR /sm-root
RUN wget https://hg.mozilla.org/mozilla-central/archive/tip.tar.gz
RUN mkdir sm
RUN tar -xf tip.tar.gz  --strip-components=1 -C sm

WORKDIR /sm-root/sm
RUN SHELL=$SHELL ./mach bootstrap --application-choice browser_artifact_mode --no-interactive || exit 0
# exit 0 because Installing Stylo and NodeJS packages requires a checkout of mozilla-central.
# Once you have such a checkout, please re-run `./mach bootstrap` from the
# checkout directory. and we dont need them
  
WORKDIR /sm-root/sm/js/src
RUN autoconf2.13
RUN mkdir build_OPT.OBJ

WORKDIR /sm-root/sm/js/src/build_OPT.OBJ
RUN SHELL=$SHELL ../configure
RUN SHELL=$SHELL make
RUN make install

WORKDIR /sm-root
RUN mkdir sm-wabt-wrapper
WORKDIR /sm-root/sm-wabt-wrapper
COPY ${PWD}/sm-wabt-wrapper/sm.ml /sm-root/sm-wabt-wrapper/sm.ml
RUN ocamlopt -o /sm-root/sm-wabt-wrapper/sm-wabt-wrapper unix.cmxa sm.ml
ENV PATH /sm-root/sm-wabt-wrapper:$PATH
ENV SM_PATH /sm-root/sm/js/src/build_OPT.OBJ/js/src/js

WORKDIR /sm-root
