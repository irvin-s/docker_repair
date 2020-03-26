FROM eosio/builder as builder

RUN git clone https://github.com/EOSIO/eos --recursive \
    && cd eos \
    && git checkout dawn-v4.0.0 \
    && git submodule update --recursive \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/usr/local  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true \
    && cmake --build /tmp/build --target install

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*

COPY nodeosd.sh /usr/local/bin/nodeosd.sh
RUN chmod +x /usr/local/bin/nodeosd.sh
RUN cp -r /tmp/build/contracts /contracts
