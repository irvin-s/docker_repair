FROM ubuntu:16.04 as builder

COPY sources.list /etc/apt/sources.list

RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo wget curl net-tools ca-certificates unzip doxygen graphviz

RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main" >> /etc/apt/sources.list.d/llvm.list \
  && wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y git-core automake autoconf libtool build-essential pkg-config libtool \
     mpi-default-dev libicu-dev python-dev python3-dev libbz2-dev zlib1g-dev libssl-dev libgmp-dev \
     clang-4.0 lldb-4.0 lld-4.0 llvm-4.0-dev libclang-4.0-dev ninja-build \
  && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-4.0/bin/clang 400 \
  && update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-4.0/bin/clang++ 400

COPY libs/cmake-3.9.6-Linux-x86_64.sh cmake-3.9.6-Linux-x86_64.sh
RUN bash cmake-3.9.6-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license \
    && rm cmake-3.9.6-Linux-x86_64.sh

ENV CC clang
ENV CXX clang++

COPY libs/ ./

RUN tar -xjf boost_1_66_0.tar.bz2 \ 
    && cd boost_1_66_0 \
    && ./bootstrap.sh --prefix=/usr/local \
    && echo 'using clang : 4.0 : clang++-4.0 ;' >> project-config.jam \
    && ./b2 -d0 -j$(nproc) --with-thread --with-date_time --with-system --with-filesystem --with-program_options \
       --with-signals --with-serialization --with-chrono --with-test --with-context --with-locale --with-coroutine --with-iostreams toolset=clang link=static install \
    && cd .. && rm -rf boost_1_66_0

RUN unzip llvm.zip \
    && cd llvm \
    && cmake -H. -Bbuild -GNinja -DCMAKE_INSTALL_PREFIX=/opt/wasm -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly -DCMAKE_BUILD_TYPE=Release  \
    && cmake --build build --target install \
    && cd .. && rm -rf llvm

RUN unzip secp256k1-zkp.zip \
    && cd secp256k1-zkp \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make -j$(nproc) install \
    && cd .. && rm -rf secp256k1-zkp

RUN tar -xzf mongo-c-driver-1.9.3.tar.gz \
    && cd mongo-c-driver-1.9.3 \
    && ./configure --disable-automatic-init-and-cleanup --prefix=/usr/local \
    && make -j$(nproc) install \
    && cd .. && rm -rf mongo-c-driver-1.9.3

RUN tar -xzf mongo-cxx-driver-r3.2.0.tar.gz \
    && cd mongo-cxx-driver-r3.2.0 \
    && cmake -H. -Bbuild -G Ninja -DCMAKE_BUILD_TYPE=Release  -DCMAKE_INSTALL_PREFIX=/usr/local\
    && cmake --build build --target install

RUN git clone -b dawn-v3.0.0 --depth 1 https://github.com/EOSIO/eos.git --recursive \
    && cd eos \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build  -DSecp256k1_ROOT_DIR=/usr/local \
    && cmake --build /tmp/build --target install
RUN mkdir -p /opt/eosio/ \
    && cp -r /tmp/build/share /opt/eosio/share \
    && cp -r /tmp/build/bin /opt/eosio/bin \
    && cp -r /tmp/build/contracts /contracts \
    && rm -rf /tmp/build && rm -rf /eos

FROM ubuntu:16.04

COPY sources.list /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /opt/eosio /opt/eosio
COPY --from=builder /contracts /contracts
COPY nodeos.sh /opt/eosio/bin/nodeos.sh
ENV EOSIO_ROOT=/opt/eosio
RUN chmod +x /opt/eosio/bin/nodeos.sh
RUN sed -i.bak 's/-I $filePath/-I $filePath -I $filePath\/../g' /opt/eosio/bin/eosiocpp
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/eosio/bin/data-dir
VOLUME /opt/eosio/bin/config-dir
VOLUME /opt/eosio/bin/contracts
ENV PATH /opt/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
WORKDIR /opt/eosio/bin