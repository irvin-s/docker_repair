FROM ubuntu:16.04

MAINTAINER John Wiegley <jwiegley@gmail.com>
LABEL Description="Software dependencies for DeepSpec Summer School 2017"

# Install basic dependencies
RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    curl ca-certificates bzip2 adduser perl python git

# Create the Nix user
RUN adduser --disabled-password --gecos '' nix && \
    mkdir -m 0755 /nix && chown nix /nix
USER nix
ENV USER nix
WORKDIR /home/nix

# Install Nix
RUN curl -o /tmp/install https://nixos.org/nix/install && sh /tmp/install

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    for i in \
      ocaml \
      ocamlPackages.camlp5_transitional \
      coq_8_6 \
      coqPackages_8_6.dpdgraph \
      coqPackages_8_6.coq-ext-lib \
      coqPackages_8_6.mathcomp \
      coqPackages_8_6.ssreflect \
      ott \
      compcert ocamlPackages.menhir \
      vim \
      emacs emacsPackages.proofgeneral_HEAD; do \
        (cd /tmp; nix-build '<nixpkgs>' --no-out-link -Q -j4 -A $i); \
    done

# Build the DSSS17 software dependencies
USER root
RUN chown -R nix /home/nix && chmod -R u+rwX /home/nix
USER nix

WORKDIR /home/nix/dsss17

COPY ./default.nix /home/nix/dsss17/default.nix

COPY ./paco.nix /home/nix/dsss17/paco.nix

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.paco

COPY ./vellvm /home/nix/dsss17/vellvm
COPY ./vellvm.nix /home/nix/dsss17/vellvm.nix

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.vellvm

COPY ./compcert.nix /home/nix/dsss17/compcert.nix

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.compcert

COPY ./QuickChick /home/nix/dsss17/QuickChick
COPY ./QuickChick.nix /home/nix/dsss17/QuickChick.nix
COPY ./QuickChick.patch /home/nix/dsss17/QuickChick.patch

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.QuickChick

COPY ./lngen /home/nix/dsss17/lngen
COPY ./lngen.nix /home/nix/dsss17/lngen.nix
COPY ./metalib /home/nix/dsss17/metalib
COPY ./metalib.nix /home/nix/dsss17/metalib.nix

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.metalib

COPY ./vst.nix /home/nix/dsss17/vst.nix
RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-build . --no-out-link -A options.dependencies.vst

COPY ./config.nix /home/nix/.config/nixpkgs/config.nix
COPY ./bashrc /home/nix/.bashrc
COPY ./init.el /home/nix/.emacs.d/init.el

RUN . ~/.nix-profile/etc/profile.d/nix.sh && \
    nix-env -iA nixpkgs.dsss17.options.build

WORKDIR /home/nix/work

CMD ["/bin/bash"]
