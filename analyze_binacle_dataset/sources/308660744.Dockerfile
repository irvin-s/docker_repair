FROM alpine:latest
RUN apk add --no-cache cmake ninja gcc g++ git musl-dev linux-headers \
        openssl openssl-dev http-parser-dev libev-dev
RUN git config --global user.email "docker@example.com"
ADD https://github.com/gabrielecirulli/2048/archive/master.zip /
RUN unzip /master.zip -d /
ADD . /src
WORKDIR /src/Debug
RUN cmake -GNinja -DNO_FUZZER_CORPUS_COLLECTION=True \
        -DCMAKE_INSTALL_PREFIX=/dst ..
RUN ninja install

FROM alpine:latest
COPY --from=0 /dst /
COPY --from=0 /2048-master /www
COPY --from=0 /src/Debug/test/dummy.* /tls/
RUN apk add --no-cache openssl http-parser libev ethtool
EXPOSE 4433/UDP
EXPOSE 4434/UDP
CMD ["/bin/server", "-i", "eth0", "-d", "/www", \
        "-c", "/tls/dummy.crt", "-k", "/tls/dummy.key"]
