# Base K3 image
FROM damsl/k3-base:latest

### Build K3 toolchain.
WORKDIR /k3/K3
RUN git pull && git checkout development

RUN cabal sandbox init && \
    cabal install --only-dependencies --ghc-options="-O2" --disable-documentation -j
 
RUN cabal configure --ghc-options="-O2" && \
    cabal build -j

### Build K3-Mosaic
WORKDIR /k3/K3-Mosaic
RUN ./build_opt.sh && \
    ./build_utils.sh

WORKDIR /k3/K3
