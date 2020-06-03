# Builds binaries for both the server and unigen, and then copies
# both binaries to a lightweight final image.
#
# Build by running 'docker build -t sweetpea/server .' from this directory.
# Push with 'docker push sweetpea/server:latest'
# Make sure you've logged in with 'docker login'
#
# Run the image locally with:
#   docker run -d -p 8080:8080 sweetpea/server:latest
#
# Then hit the API on localhost:8080

# UNIGEN
FROM debian:jessie-slim as unigen-builder

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install --yes build-essential \
    git \
    autoconf \
    libtool \
    zlib1g-dev \
    wget \
    libboost-program-options-dev \
    libm4ri-dev \
    libsqlite3-dev

RUN git clone https://bitbucket.org/kuldeepmeel/unigen && \
    cd unigen/ugen2 && \
    make -f Makefile.cvs && \
    mkdir build && \
    cd build && \
    ../configure --enable-static-link && \
    make

# The version of CMAKE in the repo is too old for cmsat.
RUN wget http://www.cmake.org/files/v3.5/cmake-3.5.2.tar.gz && \
    tar xf cmake-3.5.2.tar.gz && \
    cd cmake-3.5.2 && \
    ./configure && \
    make && \
    make install

RUN wget https://github.com/msoos/cryptominisat/archive/5.6.5.tar.gz && \
    tar xzf 5.6.5.tar.gz && \
    cd cryptominisat-5.6.5 && \
    mkdir build && cd build && \
    cmake -DSTATICCOMPILE=ON -DCMAKE_BUILD_TYPE=Release .. && \
    make

# SERVER
FROM haskell:8.2.2 as server-builder

RUN git clone https://github.com/anniecherk/sweetpea-core && \
    cd sweetpea-core && \
    git checkout 2d05fa3953c4390c81fbe8843c9a6780a76ed8a0 && \
    stack install

# FINAL IMAGE
# https://futtetennismo.me/posts/docker/2017-11-24-docker-haskell-executables.html
FROM fpco/haskell-scratch:integer-gmp

COPY --from=unigen-builder /unigen/ugen2/build/unigen /bin/
COPY --from=unigen-builder /cryptominisat-5.6.5/build/cryptominisat5 /bin/
COPY --from=server-builder /root/.local/bin/server /bin/

EXPOSE 8080

ENTRYPOINT ["server"]
