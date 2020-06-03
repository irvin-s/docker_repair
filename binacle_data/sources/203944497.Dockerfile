FROM alpine as build
RUN apk add --no-cache git make g++; \
    cd /tmp; \
    git clone https://github.com/maandree/libkeccak.git; \
    git clone https://github.com/maandree/sha3sum.git; \
    cd /tmp/libkeccak; git checkout 1.2; make install; ldconfig; \
    cd /tmp/sha3sum; make;

FROM alpine
RUN apk add --no-cache openssl && mkdir -p -- "/usr/local/include"
COPY --from=build /tmp/libkeccak/libkeccak.so /usr/local/lib/libkeccak.so.1.2
RUN ln -sf -- "/usr/local/lib/libkeccak.so.1.2" "/usr/local/lib/libkeccak.so.1" && ln -sf -- "/usr/local/lib/libkeccak.so.1.2" "/usr/local/lib/libkeccak.so"
COPY --from=build /tmp/libkeccak/libkeccak.a /usr/local/lib/libkeccak.a
COPY --from=build /tmp/libkeccak/libkeccak.h /usr/local/include
COPY --from=build /tmp/libkeccak/libkeccak-legacy.h /usr/local/include
COPY --from=build /tmp/sha3sum/keccak-256sum /usr/local/bin
COPY gen-keys.sh /
ENTRYPOINT [ "/gen-keys.sh" ]
