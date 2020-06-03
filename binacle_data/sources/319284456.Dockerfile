FROM oac/builder
ARG branch=master
ARG symbol=SYS

RUN git clone -b $branch https://github.com/OACIO/oac.git --recursive \
    && cd oac && echo "$branch:$(git rev-parse HEAD)" > /etc/oac-version \
    && cmake -H. -B"/opt/oac" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/opt/oac  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cmake --build /opt/oac --target install \
    && mv /oac/Docker/config.ini / && mv /opt/oac/contracts /contracts && mv /oac/Docker/nodoacd.sh /opt/oac/bin/nodoacd.sh && mv tutorials /tutorials \
    && rm -rf /oac

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl vim psmisc python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip3 install numpy
ENV OACIO_ROOT=/opt/oac
RUN chmod +x /opt/oac/bin/nodoacd.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/oac/bin/data-dir
ENV PATH /opt/oac/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
