FROM mato/rumprun-toolchain-hw-x86_64
MAINTAINER Richard Mortier <mort@cantab.net>

# set some OPAM options
ENV OPAMYES=1 OPAMJOBS=4

# install `opam`; add `m4` as `ocamlfind` depends on it but has no depext
RUN sudo apt-get update                                     \
    && DEBIAN_FRONTEND=noninteractive                       \
       sudo apt-get install -q -y --no-install-recommends   \
         m4 aspcud opam pkg-config libncurses5-dev          \
    && sudo apt-get clean

# initialise OPAM; add rumprun packages
RUN opam init --comp=4.02.1 --verbose --auto-setup --dot-profile=~/.bashrc  \
    && opam repository add rumprun git://github.com/mato/opam-rumprun       \
    && opam update

# install `ocaml-rumprun`; pin and install mirage.2.5.0+rumprun
RUN eval $(opam config env)                                                 \
    && RUMPRUN_PLATFORM=x86_64-rumprun-netbsd opam install ocaml-rumprun    \
    && opam pin add mirage 2.5.0+rumprun

# enter the mirage!
COPY entrypoint.sh /build/
CMD ["/bin/bash", "/build/entrypoint.sh"]
