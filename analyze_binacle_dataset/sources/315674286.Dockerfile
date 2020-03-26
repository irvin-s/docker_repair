FROM eosio/builder as builder
ARG branch=master
ARG symbol=ENU

RUN git clone -b $branch https://github.com/enumivo/enumivo.git --recursive \
    && cd enumivo && echo "$branch:$(git rev-parse HEAD)" > /etc/enumivo-version \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cmake --build /tmp/build --target install && rm /tmp/build/bin/enumivocpp

FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install vim net-tools lsof wget curl
RUN wget -O /root/.bashrc https://raw.githubusercontent.com/EOSBIXIN/eostoolkit/master/bashrc
RUN mkdir /root/enuwallet
RUN mkdir -p /opt/enumivo/bin
RUN wget -O /root/enuwallet/config.ini https://raw.githubusercontent.com/EOSBIXIN/eostoolkit/master/others/wallet_config.ini
RUN wget -O /opt/enumivo/bin/enunoded.sh https://raw.githubusercontent.com/EOSBIXIN/eostoolkit/master/others/enunoded.sh
RUN chmod a+x /opt/enumivo/bin/enunoded.sh

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /tmp/build/bin /opt/enumivo/bin
COPY --from=builder /tmp/build/contracts /contracts
COPY --from=builder /etc/enumivo-version /etc

ENV ENUMIVO_ROOT=/opt/enumivo
RUN chmod +x /opt/enumivo/bin/enunoded.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/enumivo/bin/data-dir
ENV PATH /opt/enumivo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin