# Base image is Ubuntu 14.04
FROM damsl/k3-base:latest

### Build K3
WORKDIR /k3/K3
RUN git pull && git checkout development

RUN cabal sandbox init && \
    cabal install --only-dependencies --enable-library-profiling --ghc-options="-O2 -fprof-auto" --disable-documentation -j

RUN cabal configure --enable-library-profiling --enable-profiling --ghc-options="-O2 -fprof-auto" && \
    cabal build -j

### Build K3-Mosaic
WORKDIR /k3/K3-Mosaic
RUN ./build_opt.sh && \
    ./build_utils.sh

