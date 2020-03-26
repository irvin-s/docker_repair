FROM oac/builder as builder
ARG branch=master
ARG symbol=SYS

RUN git clone -b $branch https://github.com/OACIO/oac.git --recursive \
    && cd oac && echo "$branch:$(git rev-parse HEAD)" > /etc/oac-version \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cmake --build /tmp/build --target install && rm /tmp/build/bin/oaccpp


FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /tmp/build/bin /opt/oac/bin
COPY --from=builder /tmp/build/contracts /contracts
COPY --from=builder /oac/Docker/config.ini /
COPY --from=builder /etc/oac-version /etc
COPY --from=builder /oac/Docker/nodoacd.sh /opt/oac/bin/nodoacd.sh
ENV OACIO_ROOT=/opt/oac
RUN chmod +x /opt/oac/bin/nodoacd.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/oac/bin/data-dir
ENV PATH /opt/oac/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
